terraform {
  required_version = "~> v1"
  required_providers {
    aws = {
      source = "registry.terraform.io/hashicorp/aws"
      version = "~> 3.6"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  access_key = "input"
  secret_key = "input"
}

resource "aws_eip" "lb" {
  vpc = true
}

data "aws_ami" "aws-linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "myec2" {
  ami = data.aws_ami.aws-linux.id
  instance_type = "t2.micro"
}
resource "aws_eip_association" "eip_assoc" {
  instance_id = aws_instance.myec2.id
  allocation_id = aws_eip.lb.id
}

resource "aws_security_group" "allow_tls" {
    name = "btk-security-group"
    description = "Allow TLS inboud"
    ingress {
        from_port = 443
        to_port = 443
        protocol = "TCP"
        cidr_blocks = ["${aws_eip.lb.public_ip}/32"]
    }
}

resource "aws_s3_bucket" "mys3" {
  bucket = "btk-attribute-demo01"
}


output "eip" {
  description = "EIP"
  value = aws_eip.lb.public_ip
}

output "mys3bucket" {
  value = aws_s3_bucket.mys3.bucket_domain_name
}


output "idinstance" {
    value = aws_instance.myec2.id
  
}