terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "terraform-btk"
    key = "dev/project1-vpc/terraform.tfstate"
    access_key = "input"
    secret_key = "input"
    region = "us-east-1"

    # Enable during State Locking
    dynamodb_table = "dev-project1-vpc"
  }
}

# Adding Backend as S3 for Remote backend Storage


provider "aws" {
    region = var.aws_region
    profile = "deep-dive"
}