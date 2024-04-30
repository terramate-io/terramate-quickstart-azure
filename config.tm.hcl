globals "terraform" {
  version = "1.8.2"
}

globals "terraform" "providers" "azurerm" {
  enabled = true

  source   = "hashicorp/azurerm"
  version  = "~> 3.101.0"
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

globals "azure" "oidc" {
  repository = "terramate-io/terramate-quickstart-azure"
}
