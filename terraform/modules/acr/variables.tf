variable "name" {
  description = "Globally unique name for ACR (lowercase, no hyphens)"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group for ACR"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "sku" {
  description = "ACR SKU (Basic, Standard, Premium)"
  type        = string
  default     = "Standard"
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
}