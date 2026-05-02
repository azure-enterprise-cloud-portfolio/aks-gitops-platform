# =============================================================================
# Platform Environment - Variable Definitions
# Shared services environment consumed by Dev/Test/Prod via remote state.
# Do not store secrets here — use Key Vault or pipeline secret variables.
# =============================================================================

# -----------------------------------------------------------------------------
# Region
# canadacentral = cac (used in locals.tf for resource naming)
# -----------------------------------------------------------------------------
location = "canadacentral"

# -----------------------------------------------------------------------------
# Naming Segments
# Pattern: {resource_type}-{org}-{workload}-{region}-{instance}
#
# Produces:
#   rg-cs-platform-cac
#   vnet-cs-hub-cac
#   acrcsplatformcac001
#   kv-cs-platform-cac-001
# -----------------------------------------------------------------------------
org      = "cs"
workload = "platform"
region   = "cac"
instance = "001"

# -----------------------------------------------------------------------------
# Tags
# Applied to all resources for cost allocation, ownership, and automation.
# environment : identifies this as a shared platform (not a dev/test/prod spoke)
# managed_by  : signals all infra is Terraform-managed (no manual changes)
# workload    : business context for the resources
# cost_center : used for Azure cost management filtering
# owner       : team responsible for maintaining shared platform services
# -----------------------------------------------------------------------------
tags = {
  environment = "platform"
  managed_by  = "terraform"
  workload    = "shared-services"
  cost_center = "cc-1234"       # Replace with your actual cost center code
  owner       = "platform-team" # Replace with your team or distribution list
}