# =============================================================================
# Network Module - Outputs
# =============================================================================

output "vnet_id" {
  description = "Virtual Network resource ID — referenced by hub-to-spoke and spoke-to-hub peering modules"
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "Virtual Network name — referenced by VNet peering module via virtual_network_name"
  value       = azurerm_virtual_network.this.name
}

output "subnet_ids" {
  description = "Map of subnet name -> subnet ID — referenced by AKS and private endpoint modules via subnet_ids[local.names.subnets.*]"
  value = {
    for name, subnet in azurerm_subnet.this : name => subnet.id
  }
}