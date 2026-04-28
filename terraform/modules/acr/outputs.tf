output "login_server" {
  description = "ACR login server URL"
  value       = azurerm_container_registry.this.login_server
}