#App Registration information
output "app_reg_credential_id" {
    value = azuread_application_registration.app_teams.client_id
}
