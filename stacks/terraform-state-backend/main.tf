// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}
resource "azurerm_resource_group" "tfstate" {
  location = "West Europe"
  name     = "tfstate"
}
resource "azurerm_storage_account" "tfstate" {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = azurerm_resource_group.tfstate.location
  name                     = "tfstatexscz2"
  resource_group_name      = azurerm_resource_group.tfstate.name
}
resource "azurerm_storage_container" "tfstate" {
  container_access_type = "private"
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
}
