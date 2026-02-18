output "Policy_Manifest" {
  description = "A report of all deployed governance policies pulled directly from state."
  value = {
    for key, config in module.policy_assignments : key => {
      
      # Info from module deployments
      policy_name      = config.policy_name
      display_name     = config.display_name
      assignment_id    = config.assignment_id
      managed_identity = config.identity_principal_id
      target_scope     = config.scope
      
      # Info from the remediation resource
      remediation_name = azurerm_subscription_policy_remediation.remediations[key].name
      
      resource_type_tag = var.policy_configs[key].resource_type
      assigned_roles    = keys(var.policy_configs[key].roles)
    }
  }
}