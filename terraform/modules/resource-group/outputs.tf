# =============================================================================
# Resource Group Module - Outputs
# =============================================================================

output "name" {
  description = "Resource group name — referenced by all modules in the calling environment via module.rg.name"
  value       = azurerm_resource_group.this.name
}

output "location" {
  description = "Resource group location — referenced by all modules in the calling environment via module.rg.location"
  value       = azurerm_resource_group.this.location
}