variable "environment" {
  type        = string
  default = "dev"
  description = "The target environment for deployment (e.g., dev, test, prod)."
}

variable "resource_type" {
  type        = string
  description = "The type of resource being targeted (e.g., storage, kv, sql). This is used to build the policy name."
  # Example: "stg" results in "audit-stg-platform" in your locals
}

variable "policy_display_name" {
  type        = string
  description = "The human-readable name for the policy assignment as it appears in the Azure Portal."
  # Example: "[Built-in] Storage Account Metrics"
}

variable "location" {
  type        = string
  default     = "australiasoutheast"
  description = "The Azure region where the policy assignment and remediation will reside."
}


