variable "service_name" {
  type        = string
  description = "Name of service provided by resources."
}
variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment resource is deplyed into."
}
