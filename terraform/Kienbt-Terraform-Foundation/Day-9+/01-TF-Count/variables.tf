variable "aws_region" {
  description = "Region in Which AWS Resources to be created"
  type = string
  default = "us-east-1"
}

variable "instance_type" {
  description = "Ec2 Instance type"
  type = string
  default = "t3.micro"
}

variable "instance_keypair" {
  description = "AWS Ec2 Key Pair that need to be associated with EC2 Instance"
  type = string
  default = "btk-terraform"
}

variable "instance_type_list" {
  description = "Ec2 Instance type"
  type = list(string)
  default = [ "t3.micro", "t3.small", "t3.large" ]
}

variable "instance_type_map" {
  description = "Ec2 Instance type"
  type = map(string)

  default = {
    "dev" = "t3.micro"
    "qa"  = "t3.small"
    "prod" = "t3.large"
  }
}

