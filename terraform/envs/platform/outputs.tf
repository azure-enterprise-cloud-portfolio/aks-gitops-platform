# terraform/envs/platform/outputs.tf

# Resource Group
output "resource_group_name" {
  description = "Platform resource group name"
  value       = module.rg.name
}

output "resource_group_location" {
  description = "Platform resource group location"
  value       = module.rg.location
}

# Network
output "vnet_id" {
  description = "Hub VNet ID — used for peering from spoke environments"
  value       = module.network.vnet_id
}

output "vnet_name" {
  description = "Hub VNet name"
  value       = module.network.vnet_name
}

output "subnet_ids" {
  description = "Map of subnet name to subnet ID"
  value       = module.network.subnet_ids
}

# ACR
output "acr_id" {
  description = "Container registry ID — used to grant pull access to AKS clusters"
  value       = module.acr.id
}

output "acr_login_server" {
  description = "Container registry login server URL"
  value       = module.acr.login_server
}

# Key Vault
output "key_vault_id" {
  description = "Key Vault ID — used to grant access policies to spoke workloads"
  value       = module.kv.id
}

output "key_vault_uri" {
  description = "Key Vault URI"
  value       = module.kv.uri
}