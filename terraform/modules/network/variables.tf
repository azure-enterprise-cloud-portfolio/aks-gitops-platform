# =============================================================================
# Network Module - Variable Declarations
# =============================================================================

variable "vnet_name" {
  description = "Name of the Virtual Network — sourced from local.names.vnet in the calling environment"
  type        = string
}

variable "location" {
  description = "Azure region for the Virtual Network (e.g. canadacentral)"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where the VNet and subnets will be created — sourced from module.rg.name"
  type        = string
}

variable "address_space" {
  description = "CIDR block for the VNet address space (e.g. [\"10.10.0.0/16\"] for hub, [\"10.20.0.0/16\"] for dev spoke)"
  type        = list(string)
}

variable "subnets" {
  description = "Map of subnets to create — key becomes the subnet name, value defines address_prefixes"
  type = map(object({
    address_prefixes = list(string)
  }))
}

variable "tags" {
  description = "Common governance tags applied to the VNet and all subnets"
  type        = map(string)
}