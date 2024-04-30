generate_hcl "main.tf" {
  inherit = false

  content {
    module "github_azure_oidc" {
      source  = "ned1313/github_oidc/azuread"
      version = "1.2.2"

      identity_name   = tm_try(global.azure.oidc.identity, "github-oidc-identity")
      repository_name = global.azure.oidc.repository
      entity_type     = "pull_request"
    }
  }
}
