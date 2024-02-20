variable "project_name" {
  type = string
  description = "name of project"
}

variable "vpc_cidr" {
  type = string
  description = "vpc cidr"
}

variable "private_subnets" {
  type = list(string)
  description = "private subnets"
}

variable "public_subnets" {
  type = list(string)
  description = "public subnets"
}

variable "database_subnets" {
  type = list(string)
  description = "database subnets"
}