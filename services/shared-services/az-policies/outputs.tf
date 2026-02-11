output "storage_platform_assignment_id" {
  description = "The ID of the Storage Platform metrics policy assignment."
  value       = module.policy_storage_platform.assignment_id
}

output "storage_platform_identity_id" {
  description = "The Principal ID of the Managed Identity for the Storage policy."
  value       = module.policy_storage_platform.identity_principal_id
}