# =============================================================================
# Dev Environment
# Deploys dev workload resources and connects to shared platform services.
# All resource names are derived from locals.tf — do not hardcode names here.
# Platform outputs are consumed via data.tf (terraform_remote_state).
# =============================================================================

# =============================================================================
# Resource Group
# Logical container for all dev environment resources.
# Deployed into the dev subscription via azurerm.dev provider alias.
# =============================================================================
module "rg" {
  source = "../../modules/resource-group"

  providers = {
    azurerm = azurerm.dev
  }

  name     = local.names.resource_group # rg-cs-dev-cac
  location = var.location
  tags     = var.tags
}

# =============================================================================
# Dev Spoke Network
# Spoke VNet peered with the platform hub VNet.
# Hosts the AKS node subnet — isolated from platform shared services.
#
# Subnets:
#   snet-aks-dev - AKS node pools and pod networking (10.20.1.0/24)
# =============================================================================
module "network" {
  source = "../../modules/network"

  providers = {
    azurerm = azurerm.dev
  }

  vnet_name           = local.names.vnet # vnet-cs-spoke-dev-cac
  location            = module.rg.location
  resource_group_name = module.rg.name
  address_space       = ["10.20.0.0/16"]

  subnets = {
    # AKS node pools — sized for node count + pod CIDR overhead
    (local.names.subnets.aks) = {
      address_prefixes = ["10.20.1.0/24"]
    }
  }

  tags = var.tags
}

# =============================================================================
# AKS Cluster
# Kubernetes cluster for dev workloads.
# Deployed into the AKS subnet using Azure CNI networking.
# Pulls images from shared platform ACR via AcrPull role assignment below.
#
# node_count                 : kept low for dev — scale up for test/prod
# vm_size                    : Standard_DS2_v2 sufficient for dev workloads
# log_analytics_workspace_id : sourced from platform remote state — reuses
#                              shared platform Log Analytics workspace
# =============================================================================
module "aks" {
  source = "../../modules/aks"

  providers = {
    azurerm = azurerm.dev
  }

  name                = local.names.aks # aks-cs-dev-cac-001
  location            = module.rg.location
  resource_group_name = module.rg.name
  dns_prefix          = local.names.aks
  subnet_id           = module.network.subnet_ids[local.names.subnets.aks]

  node_count = 2
  vm_size    = "Standard_DS2_v2"

  # Sourced from platform remote state — reuses shared Log Analytics workspace
  # avoids deploying a separate workspace per environment
  # log_analytics_workspace_id = data.terraform_remote_state.platform.outputs.law_workspace_id

  tags = var.tags
}

# =============================================================================
# Spoke-to-Hub VNet Peering
# Initiates peering from the dev spoke to the platform hub.
# Created in the dev subscription — allows dev workloads to reach
# shared platform services (ACR private endpoint, Key Vault, etc.).
# =============================================================================
module "spoke_to_hub_peering" {
  source = "../../modules/vnet-peering"

  providers = {
    azurerm = azurerm.dev
  }

  name                      = "peer-spoke-dev-to-hub"
  resource_group_name       = module.rg.name
  virtual_network_name      = module.network.vnet_name
  remote_virtual_network_id = data.terraform_remote_state.platform.outputs.hub_vnet_id
}

# =============================================================================
# Hub-to-Spoke VNet Peering
# Completes the peering from the platform hub back to the dev spoke.
# Created in the platform subscription — required for bidirectional
# traffic flow between hub and spoke.
# =============================================================================
module "hub_to_spoke_peering" {
  source = "../../modules/vnet-peering"

  providers = {
    azurerm = azurerm.platform
  }

  name                      = "peer-hub-to-spoke-dev"
  resource_group_name       = data.terraform_remote_state.platform.outputs.platform_resource_group_name
  virtual_network_name      = data.terraform_remote_state.platform.outputs.hub_vnet_name
  remote_virtual_network_id = module.network.vnet_id
}

# =============================================================================
# ACR Pull Role Assignment
# Grants the AKS kubelet identity permission to pull images from the
# shared platform ACR. Scoped to the ACR resource in the platform subscription.
# Role: AcrPull — read-only image pull, no push or admin access.
# =============================================================================
resource "azurerm_role_assignment" "aks_acr_pull" {
  provider = azurerm.platform

  scope                = data.terraform_remote_state.platform.outputs.acr_id
  role_definition_name = "AcrPull"
  principal_id         = module.aks.kubelet_identity_object_id
}