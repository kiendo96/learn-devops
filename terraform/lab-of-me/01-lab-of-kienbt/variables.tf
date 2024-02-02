variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}
variable "key_name" {}
variable "region" {
  region = "us-east-1"
}

variable "network_address_space" {
  description = "Contain network address for all environment"
  type = map(string)
}

variable "subnet_count" {
  description = "Contain number of subnets"
  type = map(number)
}

variable "instance_count" {
  description = "Contain number of instance"
  type = map(number)
}

variable "billing_code_tag" {}
variable "bucket_name_prefix" {}