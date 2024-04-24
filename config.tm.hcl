globals "terraform" {
  version = "1.8.0"
}

globals "terraform" "providers" "azurerm" {
  enabled = true

  source   = "hashicorp/azurerm"
  version  = "~> 3.0.2"
  features = {}
  config = {
    skip_provider_registration = false
  }
}

globals "terraform" "backend" "azurerm" {
  resource_group_name  = "tfstate"
  storage_account_name = "tfstatexscz2"
  container_name       = "tfstate"
}
