# =============================================================================
# ACR Module - Variable Declarations
# =============================================================================

variable "name" {
  description = "Globally unique ACR name — lowercase alphanumeric, no hyphens (e.g. acrcsplatformcac001)"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where ACR will be created — sourced from module.rg.name"
  type        = string
}

variable "location" {
  description = "Azure region for ACR (e.g. canadacentral)"
  type        = string
}

variable "sku" {
  description = "ACR SKU tier — Basic (dev/test), Standard (default), Premium (private endpoints + geo-replication)"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "ACR SKU must be one of: Basic, Standard, Premium."
  }
}

# ── Security ──────────────────────────────────────────────────────────────────

variable "retention_policy_in_days" {
  description = "Number of days to retain untagged manifests before deletion. Keeps registry clean."
  type        = number
  default     = 7
}

variable "trust_policy_enabled" {
  description = "Enables content trust — only signed images can be pushed. Requires Premium SKU. Enable in prod."
  type        = bool
  default     = false
}

variable "quarantine_policy_enabled" {
  description = "Enables quarantine — images must be scanned and verified before use. Requires Premium SKU. Enable in prod."
  type        = bool
  default     = false
}

# ── Tags ──────────────────────────────────────────────────────────────────────

variable "tags" {
  description = "Common governance tags applied to the ACR"
  type        = map(string)
}