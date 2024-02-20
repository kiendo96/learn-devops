data "aws_availability_zones" "available" {}
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.project_name}-vpc"
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.available.names
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  database_subnets = var.database_subnets
  enable_nat_gateway = true
  enable_vpn_gateway = true
  create_database_subnet_group = true
}



module "alb_sg" {
  source = "terraform-in-action/sg/aws"
  vpc_id      = module.vpc.vpc_id

  ingress_rules            = [
    {
      port = 80
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "web_sg" {
  source  = "terraform-in-action/sg/aws"

  vpc_id = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules = [
    {
      port = 80
      security_groups = [module.alb_sg.security_group.id]
    }
  ]
}
module "db_sg" {
  source  = "terraform-in-action/sg/aws"
  vpc_id = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules = [
    {
      port = 5432
      security_groups = [module.web_sg.security_group.id]
    }
  ]
}

