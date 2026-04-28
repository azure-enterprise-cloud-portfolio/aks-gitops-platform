output "name" {
  description = "Resource Group name"
  value       = azurerm_resource_group.this.name
}

output "location" {
  description = "Resource Group location"
  value       = azurerm_resource_group.this.location
}