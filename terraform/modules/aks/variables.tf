# =============================================================================
# AKS Module - Variable Declarations
# =============================================================================

variable "name" {
  description = "AKS cluster name — sourced from local.names.aks in the calling environment"
  type        = string
}

variable "location" {
  description = "Azure region for the AKS cluster (e.g. canadacentral)"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where AKS will be created — sourced from module.rg.name"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS API server FQDN — sourced from local.names.aks"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for the AKS cluster. Leave null to use the latest stable Azure default."
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "Subnet ID where AKS node pool will be deployed — sourced from module.network.subnet_ids[local.names.subnets.aks]"
  type        = string
}

# ── Node Pool ─────────────────────────────────────────────────────────────────

variable "node_count" {
  description = "Number of nodes in the system node pool. Ignored when enable_auto_scaling = true."
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "VM size for AKS nodes (e.g. Standard_DS2_v2 for dev, Standard_D4s_v3 for prod)"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "os_disk_size_gb" {
  description = "OS disk size in GB for AKS nodes. Set to null to use Azure's managed default (128 GB). Minimum 30 GB for Linux nodes."
  type        = number
  default     = null
  nullable    = true
}

variable "os_sku" {
  description = "OS SKU for AKS nodes — AzureLinux is the recommended modern default"
  type        = string
  default     = "AzureLinux"

  validation {
    condition     = contains(["AzureLinux", "Ubuntu", "Windows2019", "Windows2022"], var.os_sku)
    error_message = "os_sku must be one of: AzureLinux, Ubuntu, Windows2019, Windows2022."
  }
}

variable "max_pods" {
  description = "Maximum pods per node — minimum 50 required for Azure CNI pod density"
  type        = number
  default     = 50
}

# ── Auto Scaling ──────────────────────────────────────────────────────────────

variable "enable_auto_scaling" {
  description = "Enable cluster autoscaler on the system node pool. When true, node_count is managed by the autoscaler."
  type        = bool
  default     = false
}

variable "min_count" {
  description = "Minimum number of nodes when auto scaling is enabled. Ignored when enable_auto_scaling = false."
  type        = number
  default     = 1
}

variable "max_count" {
  description = "Maximum number of nodes when auto scaling is enabled. Ignored when enable_auto_scaling = false."
  type        = number
  default     = 5
}

# ── User Node Pool ────────────────────────────────────────────────────────────

variable "enable_user_node_pool" {
  description = "Enable a dedicated user node pool for application workloads. When false, only the system node pool is created."
  type        = bool
  default     = true
}

variable "user_node_count" {
  description = "Number of nodes in the user node pool. Ignored when enable_auto_scaling = true."
  type        = number
  default     = 1
}

variable "user_vm_size" {
  description = "VM size for user node pool nodes (e.g. Standard_DS2_v2 for dev, Standard_D4s_v3 for prod)"
  type        = string
  default     = "Standard_DS2_v2"
}

# ── Upgrades ──────────────────────────────────────────────────────────────────

variable "upgrade_channel" {
  description = "AKS automatic upgrade channel — patch keeps nodes secure with minimal disruption"
  type        = string
  default     = "patch"

  validation {
    condition     = contains(["patch", "rapid", "node-image", "stable", "none"], var.upgrade_channel)
    error_message = "upgrade_channel must be one of: patch, rapid, node-image, stable, none."
  }
}

# ── AAD Integration ───────────────────────────────────────────────────────────

variable "admin_group_object_ids" {
  description = "List of Azure AD group object IDs granted cluster-admin access. Required when local_account_disabled = true."
  type        = list(string)
  default     = []
}

# ── Monitoring ────────────────────────────────────────────────────────────────

# variable "log_analytics_workspace_id" {
#  description = "Log Analytics workspace ID — used by OMS agent to forward AKS logs and metrics to the platform workspace"
#  type        = string
#}

# ── Tags ──────────────────────────────────────────────────────────────────────

variable "tags" {
  description = "Common governance tags applied to the AKS cluster"
  type        = map(string)
}