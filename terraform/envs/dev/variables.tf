# terraform/envs/dev/variables.tf

/*
  Dev Environment Variables

  - Subscription IDs are injected via GitHub Actions secrets as TF_VAR_*
  - location and tags have defaults but can be overridden via terraform.tfvars
*/

# ── Subscriptions ─────────────────────────────────────────────────────────────

variable "platform_subscription_id" {
  description = "Platform subscription ID — where shared services (ACR, Key Vault, Hub VNet) exist"
  type        = string
  # set via TF_VAR_platform_subscription_id in GitHub Actions
}

variable "dev_subscription_id" {
  description = "Dev workload subscription ID — where dev resources are deployed"
  type        = string
  # set via TF_VAR_dev_subscription_id in GitHub Actions
}

# ── Region ────────────────────────────────────────────────────────────────────

variable "location" {
  description = "Azure region for all dev resources"
  type        = string
  default     = "canadacentral"
}

# ── Tags ──────────────────────────────────────────────────────────────────────

variable "tags" {
  description = "Common governance tags applied to all dev resources"
  type        = map(string)

  default = {
    owner       = "cloudsensei"
    project     = "aks-gitops-platform"
    environment = "dev"
    managed_by  = "terraform"
  }
}