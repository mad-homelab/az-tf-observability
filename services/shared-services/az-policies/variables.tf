variable "environment" {
  type        = string
  default = "dev"
  description = "The target environment for deployment (e.g., dev, test, prod)."
}

variable "location" {
  type        = string
  default     = "australiasoutheast"
  description = "The Azure region where the policy assignment and remediation will reside."
}

variable "policy_configs" {
  type = map(object({
    policy_name = string
    display_name = string
    policy_id    = string
    enable_remediation = bool
    roles        = map(string)
  }))
  description = "Map of objects corresponding to each policy and remediation configurations."
  default     = {}
}