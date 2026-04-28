# terraform/envs/platform/variables.tf

variable "location" {
  description = "Azure region for all resources"
  type        = string
}

variable "tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default     = {}
}

variable "platform_subscription_id" {
  description = "Azure subscription ID for the platform environment"
  type        = string
  sensitive   = true
}