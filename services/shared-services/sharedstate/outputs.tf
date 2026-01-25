output "state_resource_group_name" {
  value = module.rg_state.resource_group_name
}

output "state_rg_id" {
  value = module.rg_state.rg_id
}

output "state_storage_account_name" {
  value = module.tfstate_storage.storage_account_name
}

output "state_container_name" {
  value = module.tfstate_storage.container_name
}
