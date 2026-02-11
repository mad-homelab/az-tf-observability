## Backend State Provisioning Pipeline
## Purpose
To enable the Platform Shared Services to provision standardised landing zones. This provides service teams with the autonomy to deploy and manage their own infrastructure while adhering to organizational automation and security standards. 

## Architecture & Components
This pipeline automates the “bootstrapping” of CI/CD capabilities for service teams by deploying:
* **Identity:** App Registration & Service Principal with OIDC Federation (GitHub).
* **Governance:** Dedicated Resource Groups with team-specific RBAC roles.
* **State Management:** Isolated Storage Accounts and Containers for Terraform backend state.
* **Security:** Default hardened condfigurations including disabled Shared Access Keys.

## Example Input
These variables are To add a new Team, update the sharedstate/backend-state-provisioning-dev.tfvars file. Add a new entry to the service_teams map (see below):

```hcl
service_teams = {
  "observability-core" = {
    display_name = "Observability Core"
    short_name   = "obs"
    repo_path    = "observability-core"
  },
  "iaas-platform" = {
    display_name = "IaaS Workload"
    short_name   = "iaas"
    repo_path    = "iaas-worload"
  }
}

environment = "dev"
location = “australiasoutheast”
```

## Naming convention
RG Name:
- `<service>-rg-<environment>`

Example:
- `observability-rg-dev`

Storage Acct Name:
- `madhl<service short name><environment>`

Example:
- `madhlobsdev`

Container Name:
- `<service short name>-tfstate<environment>`

Example:
- `obs-tfstate-dev`

## Post-Deployment Handoff
This pipeline is designed to provide a complete manifest of the service teams’ resources to be used in their respective backend state files. Ensure this information is properly handed over to the team. Future capabilities of automatically sending this information over is being considered for the next phase of this project’s development.

```hcl
output "service_handoff_manifest" {
  description = "Inventory of provisioned resources. Use these values for your backend file."
  value = {
    for k, v in var.service_teams : k => {
      # Pulling directly from the Module Outputs
      resource_group_name  = module.service_team_rgs[k].resource_group_name
      storage_account_name = module.service_team_storage_accts[k].storage_account_name
      container_name       = module.service_team_storage_accts[k].container_name
      
      # Identity Data
      client_id            = azuread_application.app_teams[k].client_id
      subscription_id      = data.azurerm_client_config.current.subscription_id
      tenant_id            = data.azurerm_client_config.current.tenant_id
    }
  }
}
```

## Example: Service Team Backend Configuration

```hcl
    resource_group_name  = "<enter your rg>"
    storage_account_name = "<enter your storage acct name>"
    container_name       = "<enter your container name>"
    key                  = "<yourstatefilename>.tfstate"

    # Security & Authentication (required)
    use_oidc         = true
    use_azuread_auth = true
```
