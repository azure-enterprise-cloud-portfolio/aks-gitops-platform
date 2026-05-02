# =============================================================================
# Platform Environment — Terraform & Provider Configuration
#
# - Backend stores platform state separately from workload environments
# - Single provider alias for platform subscription
# - Subscription ID injected via TF_VAR_* from GitHub Actions secrets
# - OIDC authentication used throughout — no client secrets stored in pipeline
# =============================================================================

# ── Terraform ─────────────────────────────────────────────────────────────────

terraform {
  required_version = "~> 1.14.0" # Align with TF_VERSION in terraform-platform.yml

  # =============================================================================
  # Remote State Backend
  # Platform state is stored in its own key, isolated from workload environments.
  # All environments share the same storage account but write to separate state files.
  #
  # State key structure:
  #   platform/terraform.tfstate          ← this file
  #   workload/dev/terraform.tfstate      ← dev environment
  #   workload/test/terraform.tfstate     ← test environment
  #   workload/prod/terraform.tfstate     ← prod environment
  # =============================================================================
  backend "azurerm" {
    resource_group_name  = "rg-cs-tfstate-cac"
    storage_account_name = "stcstfstatecac001"
    container_name       = "tfstate"
    key                  = "platform/terraform.tfstate"
    use_oidc             = true # Authenticates backend access via OIDC — no storage access keys needed
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0" # Allows 4.x minor/patch updates, blocks 5.x breaking changes
    }
  }
}

# ── Provider ──────────────────────────────────────────────────────────────────

# =============================================================================
# Provider: Platform Subscription
# Single provider for the platform environment — no alias needed since
# all resources are deployed into the same subscription.
# Authentication via OIDC — no client secrets stored in pipeline.
# =============================================================================
provider "azurerm" {
  subscription_id = var.platform_subscription_id
  use_oidc        = true
  features {}
}