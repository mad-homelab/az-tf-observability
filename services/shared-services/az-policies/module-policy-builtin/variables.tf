variable "policy_name" {
  type        = string
  description = "A unique short name for the assignment (max 24 characters)."
}

variable "display_name" {
  type        = string
  description = "The friendly name shown in the Azure Portal compliance dashboard."
}

variable "subscription_id" {
  type        = string
  description = "The full resource ID of the subscription where the policy applies."
}

variable "location" {
  type        = string
  description = "The region for the Managed Identity (e.g., australiasoutheast)."
}

variable "builtin_policy_id" {
  type        = string
  description = "The definition ID of the Microsoft-managed policy."
}

variable "law_id" {
  type        = string
  description = "The resource ID of the central Log Analytics Workspace."
}

variable "role_definition_name" {
  type        = list(string)
  default     = []
  description = "List of Role IDs granted to the policy for remediation tasks. Ensure you assign roles with the minimum privilege required to accomplish the tasks."
}