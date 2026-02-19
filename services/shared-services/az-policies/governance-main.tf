locals {
  law_name = "observability-law-${var.environment}"
  law_resource_group = "observability-core-rg-${var.environment}"  
}

# Find subscription
data "azurerm_subscription" "current" {}

# Find central log analytics workspace
data "azurerm_log_analytics_workspace" "central" {
  name                = local.law_name
  resource_group_name = local.law_resource_group
}

module "policy_assignments" {
  source            = "./module-policy-builtin"
  for_each = var.policy_configs

  policy_name       = "audit-${each.value.policy_name}-${var.environment}"
  display_name      = each.value.display_name
  subscription_id   = data.azurerm_subscription.current.id
  builtin_policy_id = each.value.policy_id
  role_definition_name = values(each.value.roles)
  location          = var.location  
  # Pass central log analytics workspace id
  law_id            = data.azurerm_log_analytics_workspace.central.id
}

resource "azurerm_subscription_policy_remediation" "remediations" {
for_each = { 
    for key, config in var.policy_configs : key => config 
    if config.enable_remediation && length(config.roles) > 0
  }
  name                 = "remediate-${each.value.policy_name}-${var.environment}"
  subscription_id      = data.azurerm_subscription.current.id
  policy_assignment_id = module.policy_assignments[each.key].assignment_id

  depends_on = [module.policy_assignments]
}

