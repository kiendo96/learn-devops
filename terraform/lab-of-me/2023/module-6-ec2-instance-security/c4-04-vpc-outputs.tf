# VPC Output Values

# VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value = module.vpc.vpc_id
}

# VPC CIDR Blocks
output "vpc_cidr_block" {
  description = "the CIDR block of the VPC"
  value = module.vpc.vpc_cidr_block
}

# VPC Private subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value = module.vpc.private_subnets
}

#VPC Public Subnets
output "public_subnets" {
  description = "List of IDs of public subnets"
  value = module.vpc.public_subnets
}

#VPC Nat Gateway PublicIP
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateways"
  value = module.vpc.nat_public_ips
}

# VPC AZs
output "azs" {
  description = "A list of availability zonese specified as argument to this module"
  value = module.vpc.azs
}