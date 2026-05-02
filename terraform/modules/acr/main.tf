# =============================================================================
# Azure Container Registry (ACR) Module
# Central container registry for storing and distributing container images.
# Deployed in the platform environment and shared across dev/test/prod via
# AcrPull role assignments scoped to each environment's AKS kubelet identity.
#
# Security defaults:
#   admin_enabled             = false — RBAC only, no username/password access
#   trust_policy_enabled      = false — enable in prod for signed images only
#   quarantine_policy_enabled = false — enable in prod for image scanning
#   retention_policy_in_days  = 7    — cleanup untagged manifests automatically
# =============================================================================
resource "azurerm_container_registry" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku

  # Disables the built-in admin account — all access must go through
  # Azure RBAC (AcrPull / AcrPush role assignments)
  admin_enabled = false

  # Removes untagged manifests after 7 days — prevents registry bloat
  retention_policy_in_days = var.retention_policy_in_days

  # Content trust — only signed images can be pushed to the registry
  # Requires Premium SKU — keep false for dev, enable for prod
  trust_policy_enabled = var.trust_policy_enabled

  # Quarantine — images must be scanned and verified before use
  # Requires Premium SKU — keep false for dev, enable for prod
  quarantine_policy_enabled = var.quarantine_policy_enabled

  tags = var.tags
}