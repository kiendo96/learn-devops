variable "vnet_name" {
  description = "Virtual Network Name"
  type = string
  default = "vnet-default"
}

variable "vnet_address_space" {
  description = "Virtual Address Space"
  type = list(string)
  default = [ "10.0.0.0/16" ]
}

variable "web_subnet_name" {
  description = "Virtual Network Web Subnet Name"
  type = string
  default = "websubnet"
}

variable "web_subnet_address" {
  description = "Virtual Network Web Subnet Address Space"
  type = list(string)
  default = [ "10.0.1.0/24" ]
}

variable "app_subnet_name" {
  description = "Virtual Network App Subnet Name"
  type = string
  default = "appsubnet"
}

variable "app_subnet_address" {
  description = "Virtual Network App Subnet Address Space"
  type = list(string)
  default = [ "10.0.11.0/24" ]
}

variable "db_subnet_name" {
  description = "Virtual Network Database Subnet Name"
  type = string
  default = "dbsubnet"
}

variable "db_subnet_address" {
  description = "Virtual Network Database Subnet Address Spaces"
  type = list(string)
  default = ["10.0.21.0/24"]
}


variable "bastion_subnet_name" {
  description = "Virtual Network Bastion Subnet Name"
  type = string
  default = "bastionsubnet"
}

variable "bastion_subnet_address" {
  description = "Virtual Network Bastion Subnet Address Spaces"
  type = list(string)
  default = ["10.0.100.0/24"]
}

