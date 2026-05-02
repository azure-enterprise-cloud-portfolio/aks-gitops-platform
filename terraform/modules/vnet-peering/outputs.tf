# =============================================================================
# VNet Peering Module - Outputs
# =============================================================================

output "id" {
  description = "VNet peering resource ID — can be referenced to verify peering state or create dependencies"
  value       = azurerm_virtual_network_peering.this.id
}

output "name" {
  description = "VNet peering name — useful for referencing the peering link in diagnostics and monitoring"
  value       = azurerm_virtual_network_peering.this.name
}