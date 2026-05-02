# =============================================================================
# Platform Environment
# Deploys shared services used across Dev/Test/Prod environments.
# All resource names are derived from locals.tf — do not hardcode names here.
# =============================================================================

# =============================================================================
# Resource Group
# Logical container for all platform-shared resources.
# All modules below inherit location and name from this output.
# =============================================================================
module "rg" {
  source = "../../modules/resource-group"

  name     = local.names.resource_group # rg-cs-platform-cac
  location = var.location
  tags     = var.tags
}

# =============================================================================
# Virtual Network (Hub)
# Central hub VNet for the platform environment.
#
# Subnets:
#   snet-shared-services   - Hosts shared platform workloads (10.10.1.0/24)
#   snet-private-endpoints - Dedicated subnet for all private endpoint NICs
#                            (10.10.2.0/24). Isolating PEs here simplifies
#                            NSG rules and private DNS resolution.
# =============================================================================
module "network" {
  source = "../../modules/network"

  vnet_name           = local.names.vnet # vnet-cs-hub-cac
  location            = module.rg.location
  resource_group_name = module.rg.name
  address_space       = ["10.10.0.0/16"]

  subnets = {
    # General compute and shared platform workloads
    (local.names.subnets.shared_services) = {
      address_prefixes = ["10.10.1.0/24"]
    }
    # All private endpoint NICs land here to keep PE traffic isolated
    (local.names.subnets.private_endpoints) = {
      address_prefixes = ["10.10.2.0/24"]
    }
  }

  tags = var.tags
}

# =============================================================================
# Azure Container Registry (ACR)
# Shared registry used by all environments (dev/test/prod) to push and pull
# images. Downstream workloads reference the login server output via
# terraform_remote_state to configure imagePullSecrets and pipeline steps.
#
# Note: ACR names must be globally unique and contain no hyphens.
# =============================================================================
module "acr" {
  source = "../../modules/acr"

  name                = local.names.acr # acrcsplatformcac001
  resource_group_name = module.rg.name
  location            = module.rg.location
  tags                = var.tags
}

# =============================================================================
# Key Vault
# Centralized secrets store for the platform environment.
# Holds credentials, certificates, and keys shared across workloads.
# Downstream environments reference key_vault_id via terraform_remote_state
# to scope their own access policies or RBAC assignments.
#
# Note: Key Vault names must be globally unique, 3-24 chars, hyphens allowed.
# =============================================================================
module "kv" {
  source = "../../modules/keyvault"

  name                = local.names.key_vault # kv-cs-platform-cac-001
  resource_group_name = module.rg.name
  location            = module.rg.location
  tags                = var.tags
}