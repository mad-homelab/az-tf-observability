State Storage

## Purpose
This module provisions the essential infrastructure required to store and manage Terraform state files. It serves as the initial **Bootstrap** layer, creating the secure storage environment necessary for subsequent infrastructure-as-code deployments.

---

## What it creates
* **Resource Group**: A dedicated container to isolate state management resources.
* **Storage Account**: A secure storage instance configured for hosting mission-critical state files.
* **Storage Container**: The specific blob container where `.tfstate` files are stored.

---

## Architecture & Components
This module is designed to support a **Hierarchical State Strategy**. It provides the physical storage used by GitHub Actions to maintain the "source of truth" for the platform's infrastructure.


### Key Features
* **Keyless-Ready Security**: By setting `shared_access_key_enabled = false`, this module enforces **Identity-based Access (RBAC)**, aligning with modern security standards and preventing the use of long-lived storage keys.
* **Naming Validation**: Enforces strict regex patterns for storage and container naming to prevent deployment failures due to Azure naming restrictions.
* **Network Posture**: Supports toggling public network access, allowing for future hardening once private networking is established.

---

## Required inputs
The following variables are used to configure the backend storage:

| Name | Type | Required | Default | Description |
| :--- | :--- | :--- | :--- | :--- |
| `service_name` | `string` | Yes | - | Name of service provided by resources. |
| `resource_group_name` | `string` | Yes | - | Resource Group name. |
| `storage_account_name` | `string` | Yes | `madhlfirstdev` | Custom identifiers for the storage account name (3-24 chars). |
| `container_name` | `string` | Yes | `madhlcontdev` | Blob container name for Terraform state (3-24 chars). |
| `rg_location` | `string` | Yes | `australiasoutheast` | The Azure Region in which the RG exists. |
| `resource_location` | `string` | Yes | `australiasoutheast` | The Azure Region in which the Resource exists. |
| `environment` | `string` | Yes | `dev` | Target environment (Validation: `dev` or `test`). |
| `account_tier` | `string` | Yes | `Standard` | Performance tier for the storage account. |
| `account_replication_type` | `string` | Yes | `LRS` | Data redundancy strategy (LRS, GRS, etc.). |
| `allow_public_access` | `bool` | No | `true` | Whether the storage is accessible from public networks. |
| `shared_access_key_enabled`| `bool` | No | `false` | Security Toggle: Disables shared access keys. |

---

## Naming convention
To ensure auditability and prevent naming collisions, the following convention is recommended:
`madhl<service_short_name><env>###`

* **Example**: `madhlobsdev`

---