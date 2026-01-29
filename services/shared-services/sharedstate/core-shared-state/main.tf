#Deploy RG for shared state
module "rg_state" {
    source = "../../../../modules/resource-group"

    service_name = "${var.service_name}"
    environment = "${var.environment}"
}

module "tfstate_storage" {
  source = "../../../../modules/state-storage"

  # IMPORTANT: use the RG module output, not a duplicated var
  resource_group_name    = module.rg_state.resource_group_name
  resource_location               = module.rg_state.rg_location
  storage_account_name = var.storage_account_name
  container_name       = var.container_name
  account_replication_type     = var.account_replication_type

  environment = "${var.environment}"
  service_name = "${var.service_name}"
}

