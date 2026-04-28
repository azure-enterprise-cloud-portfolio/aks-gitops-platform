variable "name" {
  description = "Globally unique Key Vault name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group for Key Vault"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "sku_name" {
  description = "Key Vault SKU"
  type        = string
  default     = "standard"
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
}