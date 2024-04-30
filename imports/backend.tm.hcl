generate_hcl "backend.tf" {
  condition = tm_alltrue([
    tm_can(tm_try(global.terraform.backend.azurerm, false)),
    !tm_contains(terramate.stack.tags, "no-backend")
  ])

  content {
    terraform {
      backend "azurerm" {
        resource_group_name  = global.terraform.backend.azurerm.resource_group_name
        storage_account_name = global.terraform.backend.azurerm.storage_account_name
        container_name       = tm_try(global.terraform.backend.azurerm.container_name, "tfstate")
        key                  = "terraform/stacks/by-id/${terramate.stack.id}/terraform.tfstate"
        use_oidc             = true
      }
    }
  }
}
