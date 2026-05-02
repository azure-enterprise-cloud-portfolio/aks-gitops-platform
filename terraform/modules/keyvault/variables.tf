# =============================================================================
# Key Vault Module - Variable Declarations
# =============================================================================

variable "name" {
  description = "Globally unique Key Vault name — 3-24 chars, alphanumeric and hyphens only (e.g. kv-cs-platform-cac-001)"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where Key Vault will be created — sourced from module.rg.name"
  type        = string
}

variable "location" {
  description = "Azure region for Key Vault (e.g. canadacentral)"
  type        = string
}

variable "sku_name" {
  description = "Key Vault SKU tier — standard (secrets/keys) or premium (HSM-backed keys)"
  type        = string
  default     = "standard"

  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "Key Vault SKU must be one of: standard, premium."
  }
}

variable "soft_delete_retention_days" {
  description = "Number of days soft-deleted secrets are retained before permanent deletion. Azure minimum is 7, compliance baseline is 90."
  type        = number
  default     = 90

  validation {
    condition     = var.soft_delete_retention_days >= 7 && var.soft_delete_retention_days <= 90
    error_message = "soft_delete_retention_days must be between 7 and 90."
  }
}

variable "tags" {
  description = "Common governance tags applied to the Key Vault"
  type        = map(string)
}