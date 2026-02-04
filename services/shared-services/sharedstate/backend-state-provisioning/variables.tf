variable service_teams {
    description = "Map of service teams to be provisioned with their own state and identity."
    type = map(object({
        display_name = string
        repo_path = string
    }))
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment resources are being deployed to."

}

variable "location" {
  type        = string
  default     = "australiaeast"
}