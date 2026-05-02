# Name of the platform resource group.
# Referenced by spoke environments via terraform_remote_state.
output "resource_group_name" {
  value = module.rg.name
}

# Full VNet resource ID.
# Used by spoke environments to establish VNet peering back to the hub.
output "vnet_id" {
  value = module.network.vnet_id
}

# Map of subnet name -> subnet ID for all subnets in the hub VNet.
# Spoke workloads reference snet-private-endpoints when deploying their own PEs.
output "subnet_ids" {
  value = module.network.subnet_ids
}

# ACR login server FQDN (e.g. acrcsplatformcac001.azurecr.io).
# Used in pipeline image push/pull steps and Kubernetes imagePullSecrets.
output "acr_login_server" {
  value = module.acr.login_server
}

# ACR resource ID.
# Used to scope AcrPull / AcrPush role assignments in spoke environments.
output "acr_id" {
  value = module.acr.id
}

# Key Vault resource ID.
# Used by spoke environments to scope access policies or RBAC assignments.
output "key_vault_id" {
  value = module.kv.id
}

# Key Vault URI (e.g. https://kv-cs-platform-cac-001.vault.azure.net/).
# Used by applications and CSI drivers to reference secrets by URI.
output "key_vault_uri" {
  value = module.kv.vault_uri
}