##################################################################################
# CONFIGURATION 
##################################################################################

terraform {
   backend "remote" {
    organization = "terraform-foundation01"

    workspaces {
      name = "btkien-test-cli"
    }
  }
  required_providers {
      aws = {
          source = "hashicorp/aws"
          version = "~> 3.0"
      }
  }
}

##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  region = var.region
}

##################################################################################
# DATA
##################################################################################

data "aws_availability_zones" "available" {}


##################################################################################
# RESOURCES
##################################################################################

module "vpc" {
   source = "terraform-aws-modules/vpc/aws"
   version = "~> 2.0"

    name = "globo-primary"
    
    cidr  = var.cidr_block
    azs   = slice(data.aws_availability_zones.available.names, 0, var.subnet_count)
    private_subnets = var.private_subnets
    public_subnets  = var.public_subnets

    enable_nat_gateway  = false

    create_database_subnet_group = false

    tags = {
        Environment = "Production"
        Team        = "Network"
    }
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

