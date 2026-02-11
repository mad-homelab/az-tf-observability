# Find subscription
data "azurerm_subscription" "current" {}

# Find central log analytics workspace
data "azurerm_log_analytics_workspace" "central" {
  name                = "observability-law-dev"  
  resource_group_name = "observability-core-rg-dev"  
}

module "policy_storage_platform" {
  source            = "./module-policy-builtin"
  policy_name       = "audit-stg-platform"
  display_name      = "[Built-in] Storage Account Metrics"
  subscription_id   = data.azurerm_subscription.current.id
  location          = var.location
  builtin_policy_id = "/providers/Microsoft.Authorization/policyDefinitions/59759c62-9a22-4cdf-ae64-074495983fef"
  role_definition_ids = []
  # Pass central log analytics workspace id
  law_id            = data.azurerm_log_analytics_workspace.central.id
}

# resource "azurerm_subscription_policy_remediation" "fix_storage" {
#   name                 = "remediate-storage-platform"
#   subscription_id      = data.azurerm_subscription.current.id
#   policy_assignment_id = module.policy_storage_platform.assignment_id
# }
