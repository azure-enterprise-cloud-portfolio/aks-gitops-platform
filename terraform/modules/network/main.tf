# =============================================================================
# Network Module
# Creates a Virtual Network with dynamically defined subnets.
# Supports both hub (platform) and spoke (dev/test/prod) architectures.
#
# Subnet names are driven by the calling environment via local.names.subnets.*
# Do not hardcode subnet names here — they are passed in via var.subnets map.
# =============================================================================
resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  tags                = var.tags
}

# =============================================================================
# Subnets
# Created dynamically from the subnets map passed in by the calling environment.
# Each key becomes the subnet name, each value defines address_prefixes.
#
# Example input:
#   subnets = {
#     snet-aks-dev = { address_prefixes = ["10.20.1.0/24"] }
#   }
# =============================================================================
resource "azurerm_subnet" "this" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value.address_prefixes
}