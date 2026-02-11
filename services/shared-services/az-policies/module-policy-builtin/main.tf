
resource "azurerm_subscription_policy_assignment" "this" {
  name                 = substr(var.policy_name, 0, 24)
  subscription_id      = var.subscription_id
  policy_definition_id = var.builtin_policy_id
  location             = var.location
  display_name         = var.display_name

  parameters = jsonencode({
    logAnalytics = { value = var.law_id }
  })

  identity { type = "SystemAssigned" }
}

resource "azurerm_role_assignment" "remediation" {
  for_each             = var.role_definition_ids
  scope                = var.subscription_id
  role_definition_id   = "/providers/microsoft.authorization/roleDefinitions/${each.value}"
  principal_id         = azurerm_subscription_policy_assignment.this.identity[0].principal_id
}