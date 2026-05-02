# terraform/envs/dev/outputs.tf

/*
  Dev Environment Outputs

  - Exposes only resources owned and managed by the Dev environment
  - ACR and Key Vault live in the Platform env — access them via:
      data.terraform_remote_state.platform.outputs.<output_name>
*/

# ── Resource Group ────────────────────────────────────────────────────────────

output "rg_name" {
  description = "Dev resource group name — parent container for all dev resources"
  value       = module.rg.name
}

# ── Network ───────────────────────────────────────────────────────────────────

output "vnet_id" {
  description = "Dev spoke VNet ID — referenced by hub-to-spoke peering in platform subscription"
  value       = module.network.vnet_id
}

output "vnet_name" {
  description = "Dev spoke VNet name"
  value       = module.network.vnet_name
}

output "subnet_ids" {
  description = "Dev spoke subnet IDs — keyed by subnet name e.g. subnet_ids[\"snet-aks-dev\"]"
  value       = module.network.subnet_ids
}

# ── AKS ───────────────────────────────────────────────────────────────────────

output "aks_id" {
  description = "AKS cluster resource ID"
  value       = module.aks.aks_id
}

output "aks_kubelet_identity_object_id" {
  description = "AKS kubelet managed identity object ID — used to grant AcrPull on shared platform ACR"
  value       = module.aks.kubelet_identity_object_id
}