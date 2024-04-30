// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

data "azurerm_subscription" "current" {
}
module "github_azure_oidc" {
  entity_type     = "ref"
  identity_name   = "github-oidc-identity"
  ref_branch      = "main"
  repository_name = "terramate-io/terramate-quickstart-azure"
  source          = "ned1313/github_oidc/azuread"
  version         = "1.2.2"
}
resource "azuread_application_federated_identity_credential" "oidc_pr" {
  application_object_id = module.github_azure_oidc.azuread_application.object_id
  audiences = [
    "api://AzureADTokenExchange",
  ]
  description  = "GitHub OIDC for terramate-io/terramate-quickstart-azure PRs."
  display_name = "${module.github_azure_oidc.service_principal.display_name}-pr"
  issuer       = "https://token.actions.githubusercontent.com"
  subject      = "repo:terramate-io/terramate-quickstart-azure:pull_request"
}
resource "azurerm_role_assignment" "oidc" {
  principal_id         = module.github_azure_oidc.service_principal.object_id
  role_definition_name = "Contributor"
  scope                = data.azurerm_subscription.current.id
}
