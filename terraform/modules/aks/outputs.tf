# =============================================================================
# AKS Module - Outputs
# =============================================================================

output "id" {
  description = "AKS cluster resource ID — referenced by monitoring, policy, and diagnostic role assignments"
  value       = azurerm_kubernetes_cluster.this.id
}

output "name" {
  description = "AKS cluster name — referenced by pipeline kubectl steps and Flux/ArgoCD bootstrap"
  value       = azurerm_kubernetes_cluster.this.name
}

output "kubelet_identity_object_id" {
  description = "AKS kubelet managed identity object ID — used to scope AcrPull role assignment on shared platform ACR"
  value       = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
}