environment = "dev"
location = "australiasoutheast"

policy_configs = {
  "storage" = {
    policy_name = "stgmetrics"
    display_name = "[Built-in] Storage Account Metrics"
    policy_id    = "/providers/Microsoft.Authorization/policyDefinitions/59759c62-9a22-4cdf-ae64-074495983fef"
    
    # 2 Triggers for remediation
    # 1. Set to true once ready to trigger remediation
    enable_remediation = false
    # 2. Enter roles only after conducting an Audit
    roles        = {
      # monitoring_contributor = "/providers/Microsoft.Authorization/roleDefinitions/749f88d5-ef69-4578-8f91-690740a61031"
      # Add additional roles here if needed for this remediation
    }
  }
  # Add new object for any future policy configs here
}   