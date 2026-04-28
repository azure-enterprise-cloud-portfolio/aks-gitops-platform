output "dev_resource_group_name" {
  description = "Dev workload Resource Group name"
  value       = module.rg.name
}

output "dev_vnet_id" {
  description = "Dev Spoke VNet ID"
  value       = module.network.vnet_id
}

output "aks_name" {
  description = "AKS cluster name"
  value       = module.aks.name
}

output "aks_id" {
  description = "AKS cluster ID"
  value       = module.aks.id
}