# =============================================================================
# ACR Module - Provider Requirements
# Declares the minimum provider version this module is written against.
# The calling environment (envs/*/versions.tf) controls the actual version —
# this just ensures compatibility is explicit and enforced.
# =============================================================================
terraform {
  required_version = "~> 1.14.0" # Align with envs/*/versions.tf
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}