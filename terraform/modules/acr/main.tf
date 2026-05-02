# =============================================================================
# Azure Container Registry (ACR) Module
# Central container registry for storing and distributing container images.
# Deployed in the platform environment and shared across dev/test/prod via
# AcrPull role assignments scoped to each environment's AKS kubelet identity.
#
# Security defaults:
#   admin_enabled             = false — RBAC only, no username/password access
#   trust_policy_enabled      = false — enable in prod with Premium SKU
#   quarantine_policy_enabled = false — enable in prod with Premium SKU
#   retention_policy_in_days  = 7    — Premium SKU only, null on Standard/Basic
# =============================================================================
resource "azurerm_container_registry" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku

  # Disables the built-in admin account — all access must go through
  # Azure RBAC (AcrPull / AcrPush role assignments)
  admin_enabled = false

  # Retention, trust and quarantine policies require Premium SKU.
  # Conditionally applied — safe to use on Standard/Basic without errors.
  retention_policy_in_days  = var.sku == "Premium" ? var.retention_policy_in_days : null
  trust_policy_enabled      = var.sku == "Premium" ? var.trust_policy_enabled : false
  quarantine_policy_enabled = var.sku == "Premium" ? var.quarantine_policy_enabled : false

  tags = var.tags
}