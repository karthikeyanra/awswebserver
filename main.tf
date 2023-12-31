terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.28.0"
    }
  }
}

variable "aws_access_key_id" {
  type = string
}

variable "aws_secret_access_key" {
  type = string
}

provider "aws" {
  region = "ap-southeast-2"
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}


resource "aws_instance" "web1" {
    availability_zone = "ap-southeast-2b"
    ami = "ami-0361bbf2b99f46c1d"
    instance_type = "t2.micro"
    subnet_id = "subnet-0a17c7f4c13f71193"
    key_name = "rakarthik"
    security_groups = [ "sg-0cfb9250868d33bc0" ]
    user_data = <<EOF
#!/bin/bash
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
EOF
    tags = {
      "Name":"HTTPD"
    }
}

output "displaypublicip" {
    value = aws_instance.web1.public_ip
  
}