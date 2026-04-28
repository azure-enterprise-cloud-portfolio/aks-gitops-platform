variable "platform_subscription_id" {
  description = "Platform subscription ID where shared services exist"
  type        = string
}

variable "dev_subscription_id" {
  description = "Dev workload subscription ID"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "canadacentral"
}

variable "tags" {
  description = "Common governance tags"
  type        = map(string)

  default = {
    owner       = "cloudsensei"
    project     = "aks-gitops-platform"
    environment = "dev"
    managed_by  = "terraform"
  }
}