output rg_name {
    value = module.rg_create.rg_name
}

output rg_id {
    value = module.rg_create.rg_id
}

output rg_location {
    value = module.rg_create.rg_location
}

output law_id {
    value = azurerm_log_analytics_workspace.law_create.id
}