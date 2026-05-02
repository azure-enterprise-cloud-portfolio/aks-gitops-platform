# =============================================================================
# Key Vault Module - Outputs
# =============================================================================

output "id" {
  description = "Key Vault resource ID — used to scope RBAC role assignments in spoke environments via terraform_remote_state"
  value       = azurerm_key_vault.this.id
}

output "vault_uri" {
  description = "Key Vault URI (e.g. https://kv-cs-platform-cac-001.vault.azure.net/) — used by applications and CSI drivers to reference secrets"
  value       = azurerm_key_vault.this.vault_uri
}