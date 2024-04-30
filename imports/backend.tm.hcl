generate_hcl "backend.tf" {
  condition = tm_alltrue([
    tm_can(tm_try(global.terraform.backend.azurerm, false)),
    !tm_contains(terramate.stack.tags, "no-backend")
  ])

  content {
    terraform {
      # With OIDC
      tm_dynamic "backend" {
        condition = tm_try(global.terraform.providers.azurerm.config.use_oidc, false)
        labels    = ["azurerm"]

        content {
          resource_group_name  = global.terraform.backend.azurerm.resource_group_name
          storage_account_name = global.terraform.backend.azurerm.storage_account_name
          container_name       = tm_try(global.terraform.backend.azurerm.container_name, "tfstate")
          key                  = "terraform/stacks/by-id/${terramate.stack.id}/terraform.tfstate"
          use_oidc             = tm_try(global.terraform.providers.azurerm.config.use_oidc, false)
        }
      }

      # Without OIDC
      tm_dynamic "backend" {
        condition = tm_try(!global.terraform.providers.azurerm.config.use_oidc, true)
        labels    = ["azurerm"]

        content {
          resource_group_name  = global.terraform.backend.azurerm.resource_group_name
          storage_account_name = global.terraform.backend.azurerm.storage_account_name
          container_name       = tm_try(global.terraform.backend.azurerm.container_name, "tfstate")
          key                  = "terraform/stacks/by-id/${terramate.stack.id}/terraform.tfstate"
        }
      }
    }
  }
}
