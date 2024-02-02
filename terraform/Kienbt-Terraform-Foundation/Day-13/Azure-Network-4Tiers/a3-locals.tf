locals {
  owners = var.bussiness_division
  environment = var.environment
  resource_group_prefix = "${var.bussiness_division}-${var.environment}"

  common_tags = {
      owners = local.owners
      environment = local.environment
  }
}

