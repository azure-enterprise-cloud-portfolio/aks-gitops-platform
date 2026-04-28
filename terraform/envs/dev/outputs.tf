# ACR
output "acr_id" {
  description = "Container registry ID"
  value       = module.acr.acr_id # or acr_id, registry_id — check your module outputs
}

output "acr_login_server" {
  description = "Container registry login server URL"
  value       = module.acr.login_server
}

# Key Vault
output "key_vault_id" {
  description = "Key Vault ID"
  value       = module.kv.key_vault_id # check your module outputs
}

output "key_vault_uri" {
  description = "Key Vault URI"
  value       = module.kv.key_vault_uri # check your module outputs
}