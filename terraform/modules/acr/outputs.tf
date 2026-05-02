# =============================================================================
# ACR Module - Outputs
# =============================================================================

output "login_server" {
  description = "ACR login server FQDN (e.g. acrcsplatformcac001.azurecr.io) — used in pipeline push/pull steps and Kubernetes imagePullSecrets"
  value       = azurerm_container_registry.this.login_server
}

output "id" {
  description = "ACR resource ID — used to scope AcrPull role assignments in spoke environments via terraform_remote_state"
  value       = azurerm_container_registry.this.id
}