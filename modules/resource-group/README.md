# Resource Group Module

## Purpose
Creates a single Azure Resource Group using a consistent naming and tagging pattern.  
Designed to be reused across stacks with MAD Homelab

## What it creates
- `azurerm_resource_group.rg`

## Required inputs
These variables are required conceptually, but the module provides defaults so you can run it with minimal input.

| Variable       | Type   | Required | Default              | Description |
|---------------|--------|----------|----------------------|-------------|
| `service`     | string | yes      | –                    | Service or domain owner (e.g. `monitoring-core`, `iaas-app`, `paas-app`). Used for naming and tagging. |
| `environment` | string | yes       | `dev`                | Deployment environment (`dev`, `test`, `prod`). |
| `location`    | string | yes       | `australiasoutheast` | Azure region for the resource group. |


## Naming convention
The module generates the RG name in this format:

- `<service>-rg-<environment>`

Example:
- `observability-rg-dev`

## Tags
The module applies these base tags:
- `service = <service>`
- `environment = <environment>`

(If you later add a `tags` input, you can merge it with these base tags.)

## Outputs
| Output | Description |
|--------|-------------|
| `rg_id`   | Resource Group ID |
| `resource_group_name` | Resource Group name |
| `rg_location` | Resource Group location |

## Example usage
```hcl
module "rg" {
  source = "../../../modules/resource-group"

  location    = "australiasoutheast"
  service     = "observability"
  environment = "dev"
}
