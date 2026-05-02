# =============================================================================
# Platform Environment - Variable Declarations
# Values are supplied via terraform.tfvars or pipeline variable groups.
# Do not set sensitive values here — use Key Vault or pipeline secret variables.
# =============================================================================

# -----------------------------------------------------------------------------
# Region
# -----------------------------------------------------------------------------
variable "location" {
  description = "Azure region for all resources (e.g. canadacentral)"
  type        = string
}

# -----------------------------------------------------------------------------
# Naming Segments
# Consumed by locals.tf to dynamically construct all resource names.
# Pattern: {resource_type}-{org}-{workload}-{region}-{instance}
# -----------------------------------------------------------------------------
variable "org" {
  description = "Organization or team abbreviation used in resource naming (e.g. cs)"
  type        = string
}

variable "workload" {
  description = "Workload or environment name used in resource naming (e.g. platform, dev, prod)"
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

# -----------------------------------------------------------------------------
# Tags
# -----------------------------------------------------------------------------
variable "tags" {
  description = "Tags applied to all resources for cost allocation and ownership tracking"
  type        = map(string)
  default     = {}
}

# -----------------------------------------------------------------------------
# Subscription
# marked sensitive so the value is redacted in plan and apply output
# -----------------------------------------------------------------------------
variable "platform_subscription_id" {
  description = "Azure subscription ID for the platform environment"
  type        = string
  sensitive   = true
}

# -----------------------------------------------------------------------------
# Dev Service Principal
# Display name of the dev SP — resolved dynamically from Azure AD.
# Used to grant User Access Administrator on ACR for AcrPull role assignment.
# -----------------------------------------------------------------------------
variable "dev_sp_name" {
  description = "Display name of the dev service principal — used to resolve object ID dynamically from Azure AD"
  type        = string
}