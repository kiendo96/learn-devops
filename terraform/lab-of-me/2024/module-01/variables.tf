variable "network_address_space" {
  description = "Contain network address for all environment"
  type = map(string)
}
variable "subnet_count" {
    description = "Contain subnet number of all environment"
    type = map(string)
}
variable "billing_code_tags" {}

locals {
  env_name = lower(terraform.workspace)

  common_tags = {
    BillingCode = var.billing_code_tags
    Environment = local.env_name
  }
}