# =============================================================================
# VNet Peering Module
# Creates a single directional VNet peering link between two VNets.
# Must be called twice for bidirectional connectivity:
#   1. Spoke → Hub (azurerm.dev provider)
#   2. Hub → Spoke (azurerm.platform provider)
#
# allow_forwarded_traffic = true  — required for hub-spoke traffic routing
# allow_gateway_transit   = true  — set on hub side if sharing VPN/ExpressRoute
# use_remote_gateways     = true  — set on spoke side to use hub gateway
# =============================================================================
resource "azurerm_virtual_network_peering" "this" {
  name                      = var.name
  resource_group_name       = var.resource_group_name
  virtual_network_name      = var.virtual_network_name
  remote_virtual_network_id = var.remote_virtual_network_id

  # Allows VMs in peered VNets to communicate with each other
  allow_virtual_network_access = true

  # Required for hub-spoke — allows traffic from spoke to flow through hub
  allow_forwarded_traffic = true

  # Set to true on the hub side when sharing a VPN or ExpressRoute gateway.
  # Kept false by default — enable when gateway is added to hub VNet.
  allow_gateway_transit = var.allow_gateway_transit

  # Set to true on the spoke side to route traffic through the hub gateway.
  # Requires allow_gateway_transit = true on the hub side first.
  use_remote_gateways = var.use_remote_gateways
}