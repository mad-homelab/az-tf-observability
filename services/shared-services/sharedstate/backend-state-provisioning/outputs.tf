#App Registration information
output "app_reg_client_id" {
    description = "The Client IDs for the team identities"
    value = {
    for name, app in azuread_application.app_teams : name => app.client_id
  }
}
