# terraform/envs/dev/versions.tf

/*
  Dev Environment — Terraform & Provider Configuration

  - Backend stores dev state separately from platform
  - Two provider aliases: dev (workload) and platform (shared services)
  - Subscription IDs injected via TF_VAR_* from GitHub Actions secrets
*/

# ── Terraform ─────────────────────────────────────────────────────────────────

terraform {
  required_version = ">= 1.6.0"

  # Dev state file — separate from platform state
  backend "azurerm" {
    resource_group_name  = "rg-cs-tfstate-cac"
    storage_account_name = "stcstfstatecac001"
    container_name       = "tfstate"
    key                  = "workload/dev/terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# ── Providers ─────────────────────────────────────────────────────────────────

# Dev workload subscription — deploys rg, network, aks, spoke peering
provider "azurerm" {
  alias           = "dev"
  subscription_id = var.dev_subscription_id
  features {}
}

# Platform subscription — deploys hub-to-spoke peering and ACR role assignment
provider "azurerm" {
  alias           = "platform"
  subscription_id = var.platform_subscription_id
  features {}
}