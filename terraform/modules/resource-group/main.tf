/*
  Resource Group Module

  - Creates a logical container for Azure resources
  - Used across platform and workload environments
*/

resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location
  tags     = var.tags
}