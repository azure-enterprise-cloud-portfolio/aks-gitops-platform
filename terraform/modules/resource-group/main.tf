# =============================================================================
# Resource Group
# Logical container for all resources in a given environment.
# Used across platform and workload environments (dev/test/prod).
#
# Note: All modules in an environment inherit location and name from this
# resource via module.rg.location and module.rg.name.
# =============================================================================
resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location
  tags     = var.tags
}