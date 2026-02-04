variable "service_name" {
  type        = string
  description = "Name of service provided by resources."
}

variable "rg_location" {
  type        = string
  default     = "australiasoutheast"
  description = "The Azure Region in which the RG exists."
}

variable "resource_location" {
  type        = string
  default     = "australiasoutheast"
  description = "The Azure Region in which the Resource exists."
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment resources are being deployed to."

  validation {
    condition = contains(["dev", "test"], var.environment)
    error_message = "Environment must be dev or test."
  }

}

variable "resource_group_name" {
  type        = string
  description = "Resource Group name"
}

variable "storage_account_name" {
    type = string
    description = "Use this to append any custom identifiers in the standard storage account name."
  validation {
    condition     = can(regex("^[a-z0-9-]{3,24}$", var.storage_account_name))
    error_message = "container_name must be 3-24 chars, lowercase letters/numbers/dashes."
  }
}

variable "container_name" {
    type = string
    description = "Blob container name to store Terraform state."
  validation {
    condition     = can(regex("^[a-z0-9-]{3,24}$", var.container_name))
    error_message = "container_name must be 3-24 chars, lowercase letters/numbers/dashes."
  }
}

variable "account_tier" {
  type        = string
  default     = "Standard"
  description = "Name of service provided by resources."
}

variable "account_replication_type" {
  type        = string
  default     = "GRS"
  description = "Name of service provided by resources."
}

variable "allow_public_network_access" {
    type = bool
    default = true
    description = "Whether the storage account is accessible from public networks."
}

variable "shared_access_key_enabled" {
    type = bool
    default = false
    description = "Whether users can use shared access keys for access to storage accounts, containers, blobs, etc. Recommended setting: false."
}