locals {
  owners = var.business_division
  environment = lower(terraform.workspace)
  name = "${local.owners}-${local.environment}"
  common_tag = {
    owners = local.owners
    environment = local.environment
  }
  s3_bucket_name = "${var.bucket_name_prefix}-${local.environment}-${random_integer.rand.result}"
}