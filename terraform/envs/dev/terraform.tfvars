# =============================================================================
# Dev Environment - Variable Definitions
# Workload environment — consumes shared platform services via remote state.
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
#   rg-cs-dev-cac
#   vnet-cs-spoke-dev-cac
#   aks-cs-dev-cac
#   snet-aks-dev
# -----------------------------------------------------------------------------
org      = "cs"
workload = "dev"
region   = "cac"
instance = "001"

# -----------------------------------------------------------------------------
# Tags
# Applied to all resources for cost allocation, ownership, and automation.
# environment : identifies the SDLC stage (dev / test / prod)
# managed_by  : signals all infra is Terraform-managed (no manual changes)
# workload    : descriptive label used for cost filtering
# cost_center : used for Azure cost management filtering
# owner       : team or individual responsible for this environment
# -----------------------------------------------------------------------------
tags = {
  environment = "dev"
  managed_by  = "terraform"
  workload    = "dev-workload"
  cost_center = "cc-1234"  # Replace with your actual cost center code
  owner       = "dev-team" # Replace with your team or distribution list
}

# -----------------------------------------------------------------------------
# Service Principal
# Display name of the SP running Terraform in GitHub Actions.
# Used to grant User Access Administrator on AKS for role assignment creation.
# -----------------------------------------------------------------------------
dev_sp_name = "sp-github-aks-platform"