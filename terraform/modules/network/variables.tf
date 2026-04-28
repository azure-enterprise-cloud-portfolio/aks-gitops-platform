variable "vnet_name" {
  description = "Name of the Virtual Network (Hub)"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group where VNet will be created"
  type        = string
}

variable "address_space" {
  description = "CIDR block for the VNet"
  type        = list(string)
}

variable "subnets" {
  description = "Map of subnets to create"
  type = map(object({
    address_prefixes = list(string)
  }))
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
}