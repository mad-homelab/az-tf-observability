locals {
  law_name = "observability-law-${var.environment}"
  law_resource_group = "observability-core-rg-${var.environment}"  

  policy_name = "audit-${var.resource_type}-platform"
  policy_display_name = var.policy_display_name

  # Policy Display Name Library (Constants)
  policy_name_library = {
    storage_metrics = "[Built-in] Storage Account Metrics"
  }

    # Policy Definition Library (Constants)
  policy_library = {
    storage_metrics = "/providers/Microsoft.Authorization/policyDefinitions/59759c62-9a22-4cdf-ae64-074495983fef"
  }

  # RBAC Library (Constants)
  roles = {
    monitoring_contributor = "/providers/Microsoft.Authorization/roleDefinitions/749f88d5-ef69-4578-8f91-690740a61031"
  }

  remediate_name = "remediate-${var.resource_type}-platform"
}

# Find subscription
data "azurerm_subscription" "current" {}

# Find central log analytics workspace
data "azurerm_log_analytics_workspace" "central" {
  name                = locals.law_name
  resource_group_name = locals.law_resource_group
}

module "policy_storage_platform" {
  source            = "./module-policy-builtin"
  policy_name       = local.policy_name
  display_name      = local.policy_name_library.storage_metrics
  subscription_id   = data.azurerm_subscription.current.id
  location          = var.location
  builtin_policy_id = local.policy_library.storage_metrics
  role_definition_ids = [local.roles.monitoring_contributor]
  # Pass central log analytics workspace id
  law_id            = data.azurerm_log_analytics_workspace.central.id
}

resource "azurerm_subscription_policy_remediation" "fix_storage" {
  name                 = local.remediate_name
  subscription_id      = data.azurerm_subscription.current.id
  policy_assignment_id = module.policy_storage_platform.assignment_id

  depends_on = [module.policy_storage_platform]
}
