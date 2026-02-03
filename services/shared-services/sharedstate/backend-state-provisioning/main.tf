# Create App Reg

resource "azuread_application_registration" "app_teams" {
  for_each = var.service_teams
  display_name     = "Example Application"
  description      = "gh-identity-${each.key}-${var.environment}"
}

# Create Service Principal
resource "azuread_service_principal" "team_sps" {
  for_each  = var.service_teams
  client_id = azuread_application_registration.app_teams[each.key].client_id
}

# Setup OIDC Federated Credentials
resource "azuread_application_federated_identity_credential" "main_branch" {
  for_each       = var.service_teams
  application_id = azuread_application_registration.app_teams[each.key].id
  display_name   = "github-main-branch"
  issuer         = "https://token.actions.githubusercontent.com"
  audiences       = ["api://AzureADTokenExchange"]
  subject        = "repo:mad-homelab/az-tf-observability/${each.value.repo_path}:ref:refs/heads/main"
}
# Module Create RG
# Module Create Storage Account
# Module Create State File
# Assign RBAC RG Contributor
# Assign RBAC Storage Account Blob Contributor
