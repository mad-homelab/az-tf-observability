output "obs_resource_group_name" {
  description = "The name of the existing Resource Group used for the Observability Resources."
  value       = data.azurerm_resource_group.obs_rg.name
}

output "obs_location" {
  description = "The Azure region where the Observability Hub is deployed."
  value       = data.azurerm_resource_group.obs_rg.location
}

output law_id {
    value = azurerm_log_analytics_workspace.law_create.id
}