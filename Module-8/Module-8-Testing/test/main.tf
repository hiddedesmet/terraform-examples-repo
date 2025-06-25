provider "azurerm" {
  features {}
  subscription_id = "ffbf501f-f220-4b59-8d0a-5068d961cc5f"
}

resource "azurerm_resource_group" "rg" {
  name     = "tftest"
  location = "westeurope"
}

resource "azurerm_storage_account" "sa" {
  name                     = "${var.storage_account_name}${var.environment}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "BlobStorage"
  account_replication_type = "LRS"
}