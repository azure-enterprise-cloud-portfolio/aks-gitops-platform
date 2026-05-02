# =============================================================================
# Platform Remote State
# Reads shared platform outputs consumed by this dev environment.
#
# Provides:
#   hub_vnet_id                  → spoke-to-hub VNet peering
#   hub_vnet_name                → hub-to-spoke VNet peering
#   platform_resource_group_name → hub-to-spoke VNet peering
#   acr_id                       → AcrPull role assignment
# =============================================================================
data "terraform_remote_state" "platform" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-cs-tfstate-cac"
    storage_account_name = "stcstfstatecac001"
    container_name       = "tfstate"
    key                  = "platform/terraform.tfstate" # Platform state — separate from dev
  }
}