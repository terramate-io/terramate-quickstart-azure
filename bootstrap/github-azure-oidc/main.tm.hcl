generate_hcl "main.tf" {
  inherit = false

  content {
    data "azurerm_subscription" "current" {}

    module "github_azure_oidc" {
      source  = "ned1313/github_oidc/azuread"
      version = "1.2.2"

      entity_type     = "ref"
      ref_branch      = "main"
      identity_name   = tm_try(global.azure.oidc.identity, "github-oidc-identity")
      repository_name = global.azure.oidc.repository
    }

    resource "azuread_application_federated_identity_credential" "oidc_pr" {
      application_object_id = module.github_azure_oidc.azuread_application.object_id
      display_name          = "${module.github_azure_oidc.service_principal.display_name}-pr"
      description           = "GitHub OIDC for ${global.azure.oidc.repository} PRs."
      audiences             = ["api://AzureADTokenExchange"]
      issuer                = "https://token.actions.githubusercontent.com"
      subject               = "repo:${global.azure.oidc.repository}:pull_request"
    }

    resource "azurerm_role_assignment" "oidc" {
      scope                = data.azurerm_subscription.current.id
      role_definition_name = "Contributor"
      principal_id         = module.github_azure_oidc.service_principal.object_id
    }
  }
}
