#Require provider and version for this source
terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

# choose region
provider "aws" {
  region = "us-east-1"
}