output resource_group_name {
    value = module.rg_state.resource_group_name
}

output rg_id {
    value = module.rg_state.rg_id
}

output rg_location {
    value = module.rg_state.rg_location
}