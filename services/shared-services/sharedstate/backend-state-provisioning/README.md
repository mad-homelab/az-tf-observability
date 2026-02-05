## Backend State Provisioning Pipeline
## Purpose
To enable the Platform Shared Services to provision standardised landing zones. This provides service teams with the autonomy to deploy and manage their own infrastructure while adhering to organizational automation and security standards. 

## Architecture & Components
This pipeline automates the “bootstrapping” of CI/CD capabilities for service teams by deploying:
* **Identity:** App Registration & Service Principal with OIDC Federation (GitHub).
* **Governance:** Dedicated Resource Groups with team-specific RBAC roles.
* **State Management:** Isolated Storage Accounts and Containers for Terraform backend state.
* **Security:** Default hardened condfigurations including disabled Shared Access Keys.
