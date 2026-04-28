/*
  Azure Key Vault Module

  - Centralized secret management
  - Uses RBAC instead of access policies
*/

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  tenant_id = data.azurerm_client_config.current.tenant_id
  sku_name  = var.sku_name

  purge_protection_enabled   = true
  soft_delete_retention_days = 7

  rbac_authorization_enabled = true  # was: enable_rbac_authorization

  tags = var.tags
}