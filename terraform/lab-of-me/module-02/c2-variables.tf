#Input Variable
#AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "us-east-1"
}

#AWS EC2 Instance Type
variable "instance_type" {
  description = "EC2 Instance Type"
  type = string
  default = "t2.micro"
}

#AWS EC2 Instance key pair
variable "instance_keypair" {
  description = "AWS EC2 Key Pair that need to be associated with EC2 Instance"
  type = string
  default = "ssh-to-ec2"
}

#AWS EC2 Instance Type - list
variable "instance_type_list" {
  description = "EC2 Instance Type"
  type = list(string)
  default = [ "t2.micro", "t2.small", "t2.large" ]
}

#AWS EC2 Instance Type - map
variable "instance_type_map" {
  description = "EC2 Instance Type"
  type = map(string)
  default = {
    "dev" = "t2.micro",
    "qa"  = "t2.small",
    "prod" = "t3.large"
  }
}