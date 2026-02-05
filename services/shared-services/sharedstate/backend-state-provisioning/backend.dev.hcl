resource_group_name  = "sharedservices-rg-dev"
storage_account_name = "madhlsharedstoragedev"
container_name       = "sharedservicestfstate"
key                  = "shared-services/provisioning/dev.tfstate"

use_oidc = true
use_azuread_auth = true
