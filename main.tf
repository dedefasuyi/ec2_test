provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "0s3bucket"
    key    = "dede"
    region = "us-east-1"
  }
}


#First Tomcat server 
#this ami is for us-east-1 for ubuntu 22 pls change your own to your region
resource "aws_instance" "dev" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name = "MyDevopsClass"
  user_data = <<-EOF
  #! /bin/bash
  sudo apt-get update
  sudo apt-get install default-jdk -y
  sudo apt-get install tomcat9 -y
  sudo apt-get install tomcat9-docs tomcat9-examples tomcat9-admin -y
  sudo cp -r /usr/share/tomcat9-admin/* /var/lib/tomcat9/webapps/ -v
  EOF

  tags = {
    Name = "Dev"
  }
}
#Second Tomcat server 
#this ami is for us-east-1 for ubuntu 22 pls change your own to your region
resource "aws_instance" "QA" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.small"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name = "MyDevopsClass"
  user_data = <<-EOF
  #! /bin/bash
  sudo apt-get update
  sudo apt-get install default-jdk -y
  sudo apt-get install tomcat9 -y
  sudo apt-get install tomcat9-docs tomcat9-examples tomcat9-admin -y
  sudo cp -r /usr/share/tomcat9-admin/* /var/lib/tomcat9/webapps/ -v
  EOF

  tags = {
    Name = "QA"
  }
}

