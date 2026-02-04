
output "service_handoff_manifest" {
  description = "Inventory of provisioned resources. Use these values for your backend file."
  value = {
    for k, v in var.service_teams : k => {
      # Pulling directly from the Module Outputs
      resource_group_name  = module.service_team_rgs[k].resource_group_name
      storage_account_name = module.service_team_storage_accts[k].storage_account_name
      container_name       = module.service_team_storage_accts[k].container_name
      
      # Identity Data
      client_id            = azuread_application.app_teams[k].client_id
      subscription_id      = data.azurerm_client_config.current.subscription_id
      tenant_id            = data.azurerm_client_config.current.tenant_id
    }
  }
}