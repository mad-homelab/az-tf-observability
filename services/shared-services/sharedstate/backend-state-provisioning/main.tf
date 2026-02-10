# Create App Reg

resource "azuread_application" "app_teams" {
  for_each = var.service_teams
  display_name     = "GitHub Actions - ${each.value.display_name} - ${var.environment}"
  description      = "gh-identity-${each.key}-${var.environment}"
}

# Create Service Principal
resource "azuread_service_principal" "team_sps" {
  for_each  = var.service_teams
  client_id = azuread_application.app_teams[each.key].client_id
}

# Setup OIDC Federated Credentials
resource "azuread_application_federated_identity_credential" "team_branch" {
  for_each       = var.service_teams
  application_id = azuread_application.app_teams[each.key].id
  display_name   = "github-${each.key}-${var.environment}"
  issuer         = "https://token.actions.githubusercontent.com"
  audiences       = ["api://AzureADTokenExchange"]
  subject        = "repo:mad-homelab/az-tf-observability:environment:${var.environment}"
}

data "azurerm_client_config" "current" {}

# Module Create RG
module "service_team_rgs" {
  for_each = var.service_teams
  source = "../../../../modules/resource-group"

  service_name = each.key
  environment = var.environment
  rg_location = var.location
}

# Module Create Storage Account and State File
module "service_team_storage_accts" {
  for_each = var.service_teams
  source = "../../../../modules/state-storage"

  service_name = each.key
  shared_access_key_enabled = false
  storage_account_name = lower(substr("madhl${each.value.short_name}${var.environment}", 0, 24))
  resource_group_name = module.service_team_rgs[each.key].resource_group_name
  resource_location = module.service_team_rgs[each.key].rg_location
  container_name = "${each.value.short_name}-tfstate-${var.environment}"
}

# Assign RBAC RG Contributor
resource "azurerm_role_assignment" "service_team_rg_contributor" {
  for_each = var.service_teams
  scope = module.service_team_rgs[each.key].rg_id
  principal_id = azuread_service_principal.team_sps[each.key].object_id
  role_definition_name = "Contributor"
}

# Assign RBAC Storage Account Blob Contributor
resource "azurerm_role_assignment" "service_team_sa_data_contributor" {
  for_each = var.service_teams
  scope = module.service_team_storage_accts[each.key].storage_account_id
  principal_id = azuread_service_principal.team_sps[each.key].object_id
  role_definition_name = "Storage Blob Data Contributor"
}
