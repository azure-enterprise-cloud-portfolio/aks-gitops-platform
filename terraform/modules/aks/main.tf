# =============================================================================
# AKS Module
# Creates an Azure Kubernetes Service cluster with a system node pool.
# Uses SystemAssigned managed identity — no service principal to rotate.
# Azure CNI networking integrates directly with the spoke VNet subnet.
#
# Security defaults:
#   role_based_access_control_enabled = true  — RBAC always on
#   network_policy = "azure"                  — pod-level traffic control
#   identity.type  = "SystemAssigned"         — no credential management
#   local_account_disabled = true             — no local admin, Azure AD only
#   azure_policy_enabled = true               — governance policies enforced
#   azure_rbac_enabled = true                 — Azure RBAC for K8s authz
# =============================================================================
resource "azurerm_kubernetes_cluster" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  # Disables local admin account — all access via Azure AD and RBAC only
  local_account_disabled = true

  # Automatic patch upgrades — keeps cluster secure without manual intervention
  automatic_upgrade_channel = var.upgrade_channel

  default_node_pool {
    name            = "system"
    vm_size         = var.vm_size
    vnet_subnet_id  = var.subnet_id
    os_disk_size_gb = var.os_disk_size_gb
    os_sku          = var.os_sku

    # Minimum 50 pods per node — required for Azure CNI pod density
    max_pods = var.max_pods

    # Restricts system node pool to critical system pods only.
    # User workloads are scheduled on separate user node pools.
    only_critical_addons_enabled = true

    # Auto-scaling — enabled for test/prod, disabled for dev
    # When enabled, node_count is managed by the autoscaler
    auto_scaling_enabled = var.enable_auto_scaling
    node_count           = var.enable_auto_scaling ? null : var.node_count
    min_count            = var.enable_auto_scaling ? var.min_count : null
    max_count            = var.enable_auto_scaling ? var.max_count : null
  }

  # SystemAssigned identity — Azure manages the credential lifecycle.
  # The kubelet identity is used for AcrPull role assignments.
  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"    # Azure CNI — pods get VNet IPs directly
    network_policy    = "azure"    # Enforces pod-level network policies
    load_balancer_sku = "standard" # Required for availability zones and SLA
  }

  # Azure Policy add-on — enforces governance policies on cluster workloads
  azure_policy_enabled = true

  # OMS agent — forwards logs and metrics to Log Analytics workspace
  # oms_agent {
  #   log_analytics_workspace_id = var.log_analytics_workspace_id
  # }

  # Secrets Store CSI Driver — mounts Key Vault secrets as pod volumes
  # secret_rotation_enabled — autorotates secrets without pod restart
  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  # RBAC is always enabled — access is controlled via Azure AD and role assignments
  role_based_access_control_enabled = true

  # AAD integration — required for local_account_disabled = true (Kubernetes 1.25+)
  # azure_rbac_enabled = true delegates K8s authorization to Azure RBAC
  # admin_group_object_ids — grants cluster-admin to the AKS admins AAD group
  azure_active_directory_role_based_access_control {
    azure_rbac_enabled     = true
    admin_group_object_ids = var.admin_group_object_ids
  }

  tags = var.tags
}

# =============================================================================
# User Node Pool
# Runs user workloads — separated from the system node pool.
# system node pool: critical addons only (coredns, azure-policy etc.)
# user node pool:   all application workloads (nginx, apps, services etc.)
#
# Only created when enable_user_node_pool = true — allows dev to opt-in
# while test/prod always have a user node pool.
# =============================================================================
resource "azurerm_kubernetes_cluster_node_pool" "user" {
  count = var.enable_user_node_pool ? 1 : 0

  name                  = "user"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  vm_size               = var.user_vm_size
  vnet_subnet_id        = var.subnet_id
  os_sku                = var.os_sku
  os_disk_size_gb       = var.os_disk_size_gb
  mode                  = "User" # Allows user workloads to be scheduled here

  # Minimum 50 pods per node — required for Azure CNI pod density
  max_pods = var.max_pods

  # Auto-scaling — enabled for test/prod, disabled for dev
  auto_scaling_enabled = var.enable_auto_scaling
  node_count           = var.enable_auto_scaling ? null : var.user_node_count
  min_count            = var.enable_auto_scaling ? var.min_count : null
  max_count            = var.enable_auto_scaling ? var.max_count : null

  tags = var.tags
}