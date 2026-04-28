output "id" {
  description = "AKS cluster ID"
  value       = azurerm_kubernetes_cluster.this.id
}

output "name" {
  description = "AKS cluster name"
  value       = azurerm_kubernetes_cluster.this.name
}

output "kubelet_identity_object_id" {
  description = "AKS kubelet identity object ID used for ACR pull permissions"
  value       = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
}