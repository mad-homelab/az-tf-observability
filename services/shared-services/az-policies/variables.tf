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

variable "location" {
  type        = string
  default     = "australiasoutheast"
  description = "The Azure region where the policy assignment and remediation will reside."
}

variable "policy_configs" {
  type = map(object({
    resource_type = string
    display_name = string
    policy_id    = string
    roles        = map(string)
  }))
  description = "Map of objects corresponding to each policy and remediation configurations."
  default     = {}
}