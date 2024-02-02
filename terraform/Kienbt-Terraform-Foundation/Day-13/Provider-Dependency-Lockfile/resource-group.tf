resource "azurerm_resource_group" "myrg1" {
  name = "myrg-1"
  location = "East US"
}

resource "random_string" "myrandom" {
  length = 16
  upper = false
  special = false
}

resource "azurerm_storage_account" "mysa" {
  name = "mysa${random_string.myrandom.id}"
  resource_group_name = azurerm_resource_group.myrg1.name
  location = azurerm_resource_group.myrg1.location
  account_replication_type = "GRS"
  account_tier   = "Standard"
#   account_encryption_source = "Microsoft.Storage"
  tags = {
    environment = "dev"
  }
}