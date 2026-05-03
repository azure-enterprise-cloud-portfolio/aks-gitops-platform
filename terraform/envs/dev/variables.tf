# =============================================================================
# Dev Environment - Variable Declarations
# Subscription IDs are injected via GitHub Actions secrets as TF_VAR_*
# All other values are supplied via terraform.tfvars.
# Do not set sensitive values here — use Key Vault or pipeline secret variables.
# =============================================================================

# ── Subscriptions ─────────────────────────────────────────────────────────────

variable "platform_subscription_id" {
  description = "Platform subscription ID — where shared services (ACR, Key Vault, Hub VNet) exist"
  type        = string
  sensitive   = true
  # Injected via TF_VAR_platform_subscription_id in GitHub Actions secrets
}

variable "dev_subscription_id" {
  description = "Dev workload subscription ID — where dev resources are deployed"
  type        = string
  sensitive   = true
  # Injected via TF_VAR_dev_subscription_id in GitHub Actions secrets
}

# ── Region ────────────────────────────────────────────────────────────────────

variable "location" {
  description = "Azure region for all dev resources (e.g. canadacentral)"
  type        = string
}

# ── Naming Segments ───────────────────────────────────────────────────────────
# Consumed by locals.tf to dynamically construct all resource names.
# Pattern: {resource_type}-{org}-{workload}-{region}-{instance}

variable "org" {
  description = "Organization or team abbreviation used in resource naming (e.g. cs)"
  type        = string
}

variable "workload" {
  description = "Workload or environment name used in resource naming (e.g. dev, test, prod)"
  type        = string
}

variable "region" {
  description = "Short Azure region code used in resource naming (e.g. cac = canadacentral)"
  type        = string
}

variable "instance" {
  description = "Zero-padded instance index to support multiple deployments of the same resource (e.g. 001, 002)"
  type        = string
}

# ── Tags ──────────────────────────────────────────────────────────────────────

variable "tags" {
  description = "Common governance tags applied to all dev resources"
  type        = map(string)
  default     = {}
}

# ── Service Principal ─────────────────────────────────────────────────────────

variable "dev_sp_name" {
  description = "Display name of the dev service principal — used to resolve object ID dynamically from Azure AD"
  type        = string
}