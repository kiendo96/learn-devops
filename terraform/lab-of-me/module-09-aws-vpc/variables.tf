# AWS Region
variable "aws_region" {
  default = "us-east-1"
}

#Business Division
variable "business_division" {
  description = "contain business division"
  type = string
  default = "SAP"
}

variable "network_address_space" {
  description = "contain cidr block of vpc"
  type = map(string)
}

variable "subnet_count" {
  type = map(number)
}

variable "instance_count" {
  description = "contain number of instance"
  type = map(number)
}

variable "instance_type" {
  description = "contain type of instance"
  type = map(string)
}
variable "key_name" {
  type = string
}

#S3
variable "bucket_name_prefix" {}
variable "private_key_path" {}