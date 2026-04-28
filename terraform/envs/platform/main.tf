/*
  Platform Environment

  - Deploys shared services
  - Used across Dev/Test/Prod
*/

module "rg" {
  source = "../../modules/resource-group"

  name     = "rg-cs-platform-cac"
  location = var.location
  tags     = var.tags
}

module "network" {
  source = "../../modules/network"

  vnet_name           = "vnet-cs-hub-cac"
  location            = module.rg.location
  resource_group_name = module.rg.name
  address_space       = ["10.10.0.0/16"]

  subnets = {
    snet-shared-services = {
      address_prefixes = ["10.10.1.0/24"]
    }
    snet-private-endpoints = {
      address_prefixes = ["10.10.2.0/24"]
    }
  }

  tags = var.tags
}

module "acr" {
  source = "../../modules/acr"

  name                = "acrcsplatformcac001"
  resource_group_name = module.rg.name
  location            = module.rg.location
  tags                = var.tags
}

module "kv" {
  source = "../../modules/keyvault"

  name                = "kv-cs-platform-cac001"
  resource_group_name = module.rg.name
  location            = module.rg.location
  tags                = var.tags
}