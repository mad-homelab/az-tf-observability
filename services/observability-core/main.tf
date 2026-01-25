resource "azurerm_log_analytics_workspace" "law_create" {
  name                = "${var.service_name}-law-${var.environment}"
  location            = module.rg_create.rg_location
  resource_group_name = module.rg_create.rg_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  daily_quota_gb      = 1
  allow_resource_only_permissions = false
  internet_ingestion_enabled = true
  internet_query_enabled = true
  tags                = {
        environment   = "${var.environment}"
        service       = "${var.service_name}"
  }
}

resource "azurerm_monitor_diagnostic_setting" "example" {
  name               = "${var.service_name}-diagnostics-${var.environment}"
  target_resource_id = azurerm_log_analytics_workspace.law_create.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law_create.id

  enabled_log {
    category_group = "allLogs"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}
