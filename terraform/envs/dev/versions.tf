# =============================================================================
# Dev Environment — Terraform & Provider Configuration
#
# - Backend stores dev state separately from platform and other environments
# - Two provider aliases: dev (workload) and platform (shared services)
# - Subscription IDs injected via TF_VAR_* from GitHub Actions secrets
# - OIDC authentication used throughout — no client secrets stored in pipeline
# =============================================================================

# ── Terraform ─────────────────────────────────────────────────────────────────

terraform {
  required_version = "~> 1.14.0" # Align with TF_VERSION in terraform-dev.yml

  # =============================================================================
  # Remote State Backend
  # Dev state is stored in its own key, isolated from platform and other
  # workload environments. All environments share the same storage account
  # but write to separate state files.
  #
  # State key structure:
  #   platform/terraform.tfstate          ← shared services
  #   workload/dev/terraform.tfstate      ← this file
  #   workload/test/terraform.tfstate     ← test environment
  #   workload/prod/terraform.tfstate     ← prod environment
  # =============================================================================
  backend "azurerm" {
    resource_group_name  = "rg-cs-tfstate-cac"
    storage_account_name = "stcstfstatecac001"
    container_name       = "tfstate"
    key                  = "workload/dev/terraform.tfstate"
    use_oidc             = true # Authenticates backend access via OIDC — no storage access keys needed
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0" # Allows 4.x minor/patch updates, blocks 5.x breaking changes
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0" # Aligns with azurerm 4.x — use 2.x if on older azurerm
    }
  }
}

# ── Providers ─────────────────────────────────────────────────────────────────

# =============================================================================
# Provider: Dev Subscription
# Deploys all dev workload resources:
#   - Resource Group
#   - Spoke VNet
#   - AKS Cluster
#   - Spoke-to-Hub peering
# Authentication via OIDC — no client secrets stored in pipeline.
# =============================================================================
provider "azurerm" {
  alias           = "dev"
  subscription_id = var.dev_subscription_id
  use_oidc        = true
  features {}
}

# =============================================================================
# Provider: Platform Subscription
# Scoped to operations that must run in the platform subscription:
#   - Hub-to-Spoke VNet peering
#   - ACR Pull role assignment on shared ACR
# Uses the same OIDC identity — ensure the pipeline service principal
# has the required permissions in both subscriptions.
# =============================================================================
provider "azurerm" {
  alias           = "platform"
  subscription_id = var.platform_subscription_id
  use_oidc        = true
  features {}
}

# =============================================================================
# Provider: Azure AD
# Used to look up AAD groups dynamically — avoids hardcoding Object IDs.
# Inherits OIDC authentication from the pipeline service principal.
# Ensure the SP has Directory.Read.All or Group.Read.All in Azure AD.
# =============================================================================
provider "azuread" {
  use_oidc = true
}