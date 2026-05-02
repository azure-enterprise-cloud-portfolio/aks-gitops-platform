# =============================================================================
# Dev Service Principal Lookup
# Resolves the dev SP object ID dynamically by display name.
# Avoids hardcoding object IDs — SP is resolved at plan time from Azure AD.
# Used to grant User Access Administrator on ACR for AcrPull role assignment.
# =============================================================================
data "azuread_service_principal" "dev_sp" {
  display_name = var.dev_sp_name
}
