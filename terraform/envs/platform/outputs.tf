# =============================================================================
# Platform Environment Outputs
# Exposes shared platform resources for consumption by spoke environments
# via terraform_remote_state in dev/test/prod pipelines.
# =============================================================================

# Name of the platform resource group.
# Referenced by spoke environments via terraform_remote_state.
output "resource_group_name" {
  description = "Platform resource group name — referenced by spoke environments via terraform_remote_state"
  value       = module.rg.name
}

# Platform resource group name — used by hub-to-spoke peering in dev pipeline
output "platform_resource_group_name" {
  description = "Platform resource group name — used by hub-to-spoke peering module in dev subscription"
  value       = module.rg.name
}

# Full VNet resource ID.
# Used by spoke environments to establish VNet peering back to the hub.
output "vnet_id" {
  description = "Hub VNet resource ID"
  value       = module.network.vnet_id
}

# Hub VNet resource ID — used by dev spoke-to-hub peering
output "hub_vnet_id" {
  description = "Hub VNet resource ID — referenced by spoke-to-hub peering in dev subscription"
  value       = module.network.vnet_id
}

# Hub VNet name — used by hub-to-spoke peering in dev pipeline
output "hub_vnet_name" {
  description = "Hub VNet name — referenced by hub-to-spoke peering module in dev pipeline"
  value       = module.network.vnet_name
}

# Map of subnet name -> subnet ID for all subnets in the hub VNet.
# Spoke workloads reference snet-private-endpoints when deploying their own PEs.
output "subnet_ids" {
  description = "Map of subnet name -> subnet ID — referenced by spoke environments for private endpoints"
  value       = module.network.subnet_ids
}

# ACR login server FQDN (e.g. acrcsplatformcac001.azurecr.io).
# Used in pipeline image push/pull steps and Kubernetes imagePullSecrets.
output "acr_login_server" {
  description = "ACR login server FQDN — used in pipeline push/pull steps and Kubernetes imagePullSecrets"
  value       = module.acr.login_server
}

# ACR resource ID.
# Used to scope AcrPull / AcrPush role assignments in spoke environments.
output "acr_id" {
  description = "ACR resource ID — used to scope AcrPull role assignments in spoke environments"
  value       = module.acr.id
}

# Key Vault resource ID.
# Used by spoke environments to scope access policies or RBAC assignments.
output "key_vault_id" {
  description = "Key Vault resource ID — used by spoke environments to scope RBAC assignments"
  value       = module.kv.id
}

# Key Vault URI (e.g. https://kv-cs-platform-cac-001.vault.azure.net/).
# Used by applications and CSI drivers to reference secrets by URI.
output "key_vault_uri" {
  description = "Key Vault URI — used by applications and CSI drivers to reference secrets"
  value       = module.kv.vault_uri
}

# Log Analytics workspace ID — used by AKS OMS agent in dev
# output "law_workspace_id" {
#  description = "Log Analytics workspace ID — consumed by dev AKS OMS agent via remote state"
#  value       = module.law.workspace_id
# }