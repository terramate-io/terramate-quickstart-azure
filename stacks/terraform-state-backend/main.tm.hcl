generate_hcl "main.tf" {
  content {
    resource "random_string" "resource_code" {
      length  = 5
      special = false
      upper   = false
    }

    resource "azurerm_resource_group" "tfstate" {
      name     = global.terraform.backend.azurerm.resource_group_name
      location = "West Europe"
    }

    resource "azurerm_storage_account" "tfstate" {
      name                     = global.terraform.backend.azurerm.storage_account_name
      resource_group_name      = azurerm_resource_group.tfstate.name
      location                 = azurerm_resource_group.tfstate.location
      account_tier             = "Standard"
      account_replication_type = "LRS"

      # tags = {
      #   environment = "demo"
      # }
    }

    resource "azurerm_storage_container" "tfstate" {
      name                  = global.terraform.backend.azurerm.container_name
      storage_account_name  = azurerm_storage_account.tfstate.name
      container_access_type = "private"
    }
  }
}
