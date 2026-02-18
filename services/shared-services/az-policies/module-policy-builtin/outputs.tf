output "assignment_id" {
  description = "The ID of the policy assignment. Pass this to trigger remediation tasks."
  value       = azurerm_subscription_policy_assignment.this.id
}

output "identity_principal_id" {
  description = "The Principal ID of the Managed Identity."
  value       = azurerm_subscription_policy_assignment.this.identity[0].principal_id
}

output "policy_name" {
  value = azurerm_subscription_policy_assignment.this.name
}

output "display_name" {
  value = azurerm_subscription_policy_assignment.this.display_name
}

output "scope" {
  value = azurerm_subscription_policy_assignment.this.subscription_id
}