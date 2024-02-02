variable "bussiness_division" {
  description = "Bussiness Division in the large organization"
  type = string
  default = "sap"
}

variable "environment" {
  description = "Environment Variable use as a Prefix"
  type = string
  default = "dev"
}

variable "resource_group_name" {
  description = "Resource Group Name"
  type = string
  default = "rg-default"
}

variable "resource_group_location" {
  description = "Region in Which Azure Resources to be created"
  type = string
  default = "eastus"
}
