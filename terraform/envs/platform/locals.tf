locals {
  # =============================================================================
  # Naming Convention
  # Pattern: {resource_type}-{org}-{workload}-{region}-{instance}
  #
  # org      = organization/team abbreviation (cs)
  # workload = environment or service name (platform)
  # region   = short Azure region code (cac = canadacentral)
  # instance = zero-padded index to support multiple instances of the same
  #            resource within the same environment (e.g. 001, 002).
  #            Kept for future-proofing — naming conventions are difficult
  #            to change after resources are deployed in production.
  #
  # Example outputs:
  #   Resource Group : rg-cs-platform-cac
  #   VNet           : vnet-cs-hub-cac
  #   ACR            : acrcsplatformcac001  (no hyphens, Azure restriction)
  #   Key Vault      : kv-cs-platform-cac-001
  # =============================================================================

  # Sourced from tfvars — allows each environment (dev/test/prod/platform)
  # to override naming segments without touching this file
  org      = var.org
  workload = var.workload
  region   = var.region
  instance = var.instance

  # Shared prefix reused across all resource names
  name_prefix = "${local.org}-${local.workload}-${local.region}"

  # Centralized resource name map — all modules reference this.
  # Do not hardcode names anywhere else in the codebase.
  names = {
    resource_group = "rg-${local.name_prefix}"
    vnet           = "vnet-${local.org}-hub-${local.region}"
    acr            = "acr${local.org}${local.workload}${local.region}${local.instance}" # No hyphens allowed in ACR names
    key_vault      = "kv-${local.name_prefix}-${local.instance}"

    subnets = {
      shared_services   = "snet-shared-services"
      private_endpoints = "snet-private-endpoints"
    }
  }
}