variable "name" {
  description = "VNet peering name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group of the source VNet"
  type        = string
}

variable "virtual_network_name" {
  description = "Source VNet name"
  type        = string
}

variable "remote_virtual_network_id" {
  description = "Remote VNet ID"
  type        = string
}