terraform {
  required_version = ">= 1.6.0"

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

provider "azurerm" {
  alias           = "dev"
  subscription_id = var.dev_subscription_id
  features {}
}

provider "azurerm" {
  alias           = "platform"
  subscription_id = var.platform_subscription_id
  features {}
}