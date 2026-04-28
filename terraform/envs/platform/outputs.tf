# ACR
output "acr_id" {
  description = "Container registry ID — used to grant pull access to AKS clusters"
  value       = module.acr.acr_id  # was: module.acr.id
}

output "acr_login_server" {
  description = "Container registry login server URL"
  value       = module.acr.login_server
}

# Key Vault
output "key_vault_id" {
  description = "Key Vault ID — used to grant access policies to spoke workloads"
  value       = module.kv.key_vault_id  # was: module.kv.id
}

output "key_vault_uri" {
  description = "Key Vault URI"
  value       = module.kv.key_vault_uri  # was: module.kv.uri
}