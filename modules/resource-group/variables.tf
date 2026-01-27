variable "service_name" {
  type        = string
  description = "Name of service provided by resources."
}

variable "rg_location" {
  type        = string
  default     = "australiasoutheast"
  description = "The Azure Region in which all resources in this example should be created."
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
