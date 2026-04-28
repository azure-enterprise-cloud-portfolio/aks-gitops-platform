/*
  Azure Container Registry Module

  - Central container registry
  - Used by AKS clusters across environments
*/

resource "azurerm_container_registry" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku

  admin_enabled       = false  # Security best practice

  tags = var.tags
}