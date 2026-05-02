# =============================================================================
# Resource Group Module - Variable Declarations
# =============================================================================

variable "name" {
  description = "Name of the resource group — sourced from local.names.resource_group in the calling environment"
  type        = string
}

variable "location" {
  description = "Azure region for the resource group (e.g. canadacentral)"
  type        = string
}

variable "tags" {
  description = "Common governance tags applied to the resource group and inherited by all child resources"
  type        = map(string)
}