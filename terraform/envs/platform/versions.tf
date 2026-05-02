# terraform/envs/platform/versions.tf

terraform {
  required_version = ">= 1.6.0"

  backend "azurerm" {
    resource_group_name  = "rg-cs-tfstate-cac"
    storage_account_name = "stcstfstatecac001"
    container_name       = "tfstate"
    key                  = "platform/terraform.tfstate"
    use_oidc             = true
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.platform_subscription_id
  use_oidc        = true # ← added
  features {}
}