# terraform {
#   backend "s3" {
#     bucket = "terraform-lab-s3-backend"
#     key = "test-project"
#     region = "us-east-1"
#     encrypt = true
#     role_arn = "arn:aws:iam::309236873398:role/Terraform-LabS3BackendRole"
#     dynamodb_table = "terraform-lab-s3-backend"
#   }
# }

terraform {
  cloud {
    organization = "terraform-lab-kiendt"

    workspaces {
      name = "terraform-remote-backend"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "server" {
  ami           = data.aws_ami.ami.id
  instance_type = "t3.micro"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "Server"
  }
}

output "public_ip" {
  value = aws_instance.server.public_ip
}