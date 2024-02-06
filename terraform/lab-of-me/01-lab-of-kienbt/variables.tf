variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}
variable "key_name" {}
variable "region" {
  default = "us-east-1"
}

variable "network_address_space" {
  description = "Contain network address for all environment"
  type        = map(string)
}

variable "subnet_count" {
  description = "Contain number of subnets"
  type        = map(number)
}

variable "instance_count" {
  description = "Contain number of instance"
  type        = map(number)
}

variable "instance_size" {
  description = "Contain size of EC2 instance"
  type        = map(string)
}

variable "billing_code_tag" {}
variable "bucket_name_prefix" {}

locals {
  env_name = lower(terraform.workspace)

  common_tags = {
    BillingCode = var.billing_code_tag
    Environment = local.env_name
  }
  s3_bucket_name = "${var.bucket_name_prefix}-${local.env_name}-${random_integer.rand.result}"
}