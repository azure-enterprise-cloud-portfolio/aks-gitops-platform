# =============================================================================
# VNet Peering Module - Variable Declarations
# =============================================================================

variable "name" {
  description = "VNet peering name (e.g. peer-spoke-dev-to-hub, peer-hub-to-spoke-dev)"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group of the source VNet — sourced from module.rg.name or platform remote state"
  type        = string
}

variable "virtual_network_name" {
  description = "Source VNet name — the VNet this peering is created from"
  type        = string
}

variable "remote_virtual_network_id" {
  description = "Remote VNet resource ID — the VNet this peering connects to"
  type        = string
}

variable "allow_gateway_transit" {
  description = "Set to true on the hub side to share a VPN or ExpressRoute gateway with peered spokes"
  type        = bool
  default     = false
}

variable "use_remote_gateways" {
  description = "Set to true on the spoke side to route traffic through the hub VPN or ExpressRoute gateway. Requires allow_gateway_transit = true on hub side."
  type        = bool
  default     = false
}