# Look up the existing Resource Group created by Shared Services
data "azurerm_resource_group" "obs_rg" {
  name = "observability-core-rg-dev" # Must match exactly what was created
}

resource "azurerm_log_analytics_workspace" "law_create" {
  name                = "${var.service_name}-law-${var.environment}"
  location            = data.azurerm_resource_group.obs_rg.location
  resource_group_name = data.azurerm_resource_group.obs_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 365
  daily_quota_gb      = 1

  # Ensures users only have access to logs from resources they own/have access to
  allow_resource_only_permissions = true
  
  # Turn off once private network has been setup
  internet_ingestion_enabled =true
  
  #  Turn off once private network has been setup
  internet_query_enabled = true

  tags                = {
        environment   = var.environment
        service       = var.service_name
  }
}

# resource "azurerm_monitor_diagnostic_setting" "law_diags" {
#   name               = "${var.service_name}-diagnostics-${var.environment}"
#   target_resource_id = azurerm_log_analytics_workspace.law_create.id
#   log_analytics_workspace_id = azurerm_log_analytics_workspace.law_create.id

#   enabled_log {
#     category_group = "allLogs"
#   }

#   enabled_metric {
#     category = "AllMetrics"
#   }
# }
