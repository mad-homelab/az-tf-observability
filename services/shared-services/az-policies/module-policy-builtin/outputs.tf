output "assignment_id" {
  description = "The ID of the policy assignment. Use this to trigger remediation tasks."
  value       = azurerm_subscription_policy_assignment.this.id
}

output "identity_principal_id" {
  description = "The Principal ID of the Managed Identity. Useful for verifying RBAC in the portal."
  value       = azurerm_subscription_policy_assignment.this.identity[0].principal_id
}