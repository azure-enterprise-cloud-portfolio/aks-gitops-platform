variable "name" {
  description = "AKS cluster name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group where AKS is deployed"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for AKS"
  type        = string
}

variable "kubernetes_version" {
  description = "AKS Kubernetes version. Leave null to use Azure default."
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "Subnet ID where AKS node pool will be deployed"
  type        = string
}

variable "node_count" {
  description = "Number of AKS system node pool nodes"
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "VM size for AKS nodes"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
}