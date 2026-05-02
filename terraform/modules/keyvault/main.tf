# =============================================================================
# Key Vault Module
# Centralized secret, key, and certificate management for the platform.
# Deployed in the platform environment and shared across dev/test/prod via
# RBAC role assignments scoped to each environment's managed identities.
#
# Security defaults:
#   rbac_authorization_enabled  = true  — access policies disabled, RBAC only
#   purge_protection_enabled    = true  — prevents permanent deletion
#   soft_delete_retention_days  = 90   — compliance baseline (Azure min is 7)
# =============================================================================

# Reads the current client tenant ID — required by Key Vault for RBAC
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  # Tenant ID sourced dynamically — avoids hardcoding per environment
  tenant_id = data.azurerm_client_config.current.tenant_id
  sku_name  = var.sku_name

  # Prevents permanent deletion of the vault and its contents.
  # Required for any vault holding production-grade credentials.
  purge_protection_enabled = true

  # Azure enforces a minimum of 7 days — 90 days aligns with compliance baseline.
  # Configurable via var.soft_delete_retention_days if environment needs differ.
  soft_delete_retention_days = var.soft_delete_retention_days

  # Disables legacy access policies — all access must go through Azure RBAC.
  # Assign Key Vault Secrets Officer / Reader roles to managed identities.
  rbac_authorization_enabled = true

  tags = var.tags
}