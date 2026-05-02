/*
  Read Platform remote state

  - Gets Hub VNet ID
  - Gets ACR ID
  - Enables Dev to consume shared platform services
*/

data "terraform_remote_state" "platform" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-cs-tfstate-cac"
    storage_account_name = "stcstfstatecac001"
    container_name       = "tfstate"
    key                  = "platform/terraform.tfstate"  # ← platform state, not dev
  }
}

/*
  Dev Resource Group
*/

module "rg" {
  source = "../../modules/resource-group"

  providers = {
    azurerm = azurerm.dev
  }

  name     = "rg-cs-workload-dev-cac"
  location = var.location
  tags     = var.tags
}

/*
  Dev Spoke Network

  - Hosts AKS subnet
  - Peered with Platform Hub VNet
*/

module "network" {
  source = "../../modules/network"

  providers = {
    azurerm = azurerm.dev
  }

  vnet_name           = "vnet-cs-spoke-dev-cac"
  location            = module.rg.location
  resource_group_name = module.rg.name
  address_space       = ["10.20.0.0/16"]

  subnets = {
    snet-aks-dev = {
      address_prefixes = ["10.20.1.0/24"]
    }
  }

  tags = var.tags
}

/*
  AKS Cluster

  - Deployed into Dev spoke subnet
  - Uses Azure CNI networking
*/

module "aks" {
  source = "../../modules/aks"

  providers = {
    azurerm = azurerm.dev
  }

  name                = "aks-cs-dev-cac"
  location            = module.rg.location
  resource_group_name = module.rg.name
  dns_prefix          = "aks-cs-dev-cac"
  subnet_id           = module.network.subnet_ids["snet-aks-dev"]

  node_count = 2
  vm_size    = "Standard_DS2_v2"

  tags = var.tags
}

/*
  Spoke-to-Hub Peering

  - Created from Dev subscription side
*/

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

/*
  Hub-to-Spoke Peering

  - Created from Platform subscription side
*/

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

/*
  ACR Pull Permission

  - Grants AKS kubelet identity permission to pull images from shared ACR
*/

resource "azurerm_role_assignment" "aks_acr_pull" {
  provider = azurerm.platform

  scope                = data.terraform_remote_state.platform.outputs.acr_id
  role_definition_name = "AcrPull"
  principal_id         = module.aks.kubelet_identity_object_id
}