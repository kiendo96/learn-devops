# Terraform Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0"
    }
  }
}

# Provider Block
provider "azurerm" {
  features {}
  subscription_id = "5b0db6f2-f287-4fe6-b538-37a60dc469fd"
  client_id       = "1bd1a0a7-f2fd-4b80-b725-df233de59d0b"
  client_secret   = "l.zlFy1clT3F~LmfZbJp5e~uPEHQ9OAhus"
  tenant_id       = "7e9e0b21-8c09-46db-a063-70064daa2e7f"
}


