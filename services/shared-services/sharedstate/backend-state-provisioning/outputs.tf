#App Registration information
output "app_reg_client_id" {
    description = "The Client IDs for the team identities"
    value = {
    for name, app in azuread_application_registration.team_apps : name => app.client_id
  }
}
