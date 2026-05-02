locals {
  # =============================================================================
  # Naming Convention
  # Pattern: {resource_type}-{org}-{workload}-{region}-{instance}
  #
  # org      = organization/team abbreviation (cs)
  # workload = environment or service name (dev)
  # region   = short Azure region code (cac = canadacentral)
  # instance = zero-padded index to support multiple instances of the same
  #            resource within the same environment (e.g. 001, 002).
  #            Kept for future-proofing — naming conventions are difficult
  #            to change after resources are deployed in production.
  #
  # Example outputs:
  #   Resource Group : rg-cs-dev-cac
  #   VNet           : vnet-cs-spoke-dev-cac
  #   AKS            : aks-cs-dev-cac-001
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
  # Note: ACR and Key Vault are not deployed here — they are shared platform
  # resources consumed via terraform_remote_state (see main.tf).
  names = {
    resource_group = "rg-${local.name_prefix}"
    vnet           = "vnet-${local.org}-spoke-${local.workload}-${local.region}"
    aks            = "aks-${local.name_prefix}-${local.instance}" # aks-cs-dev-cac-001

    subnets = {
      aks               = "snet-aks-${local.workload}" # AKS node pools and pod networking
      private_endpoints = "snet-private-endpoints"     # All private endpoint NICs isolated here
    }
  }
}