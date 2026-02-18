# Core Platform Backend State

## Purpose
This service establishes the **Centralized Backend Infrastructure** for the Shared Services Platform Team. It acts as the "Root of Trust" for the entire platform, providing the secure, remote storage required to manage the Terraform state of all core observability and governance components.

---

## What it creates
* **Platform Resource Group**: A dedicated administrative boundary for shared management resources.
* **Shared Backend Storage**: A secure storage instance configured for hosting mission-critical state files.
* **TFState Container**: The primary blob container used by the CI/CD pipeline to store the "Source of Truth" for the infrastructure.

---

## Architecture & Components
This service implements the **Bootstrap Pattern**. It utilizes the `state-storage` module to enforce the platform's security baseline, ensuring that the backend itself is as secure as the infrastructure it manages.


### Key Features
* **Bootstrap Root**: This is the first service deployed in the landing zone to enable a "Secretless" GitHub Actions workflow.
* **RBAC-Ready Security**: Designed to transition into an **Identity-based Access (OIDC)** model, eliminating the risk of leaked storage keys.
* **Cost-Efficient Foundation**: Defaults to **LRS (Locally Redundant Storage)** for the development phase to balance durability with cloud spend management.

---

## Required inputs
The following variables define the parameters for the platform's shared state storage:

| Name | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `service_name` | `string` | `sharedservices` | Name of platform_service provided by resources. |
| `environment` | `string` | `dev` | Target environment (Validation: `dev` or `test`). |
| `storage_account_name` | `string` | `madhlsharedstoragedev` | Custom identifier for the storage account (3-24 chars). |
| `container_name` | `string` | `sharedservicestfstate` | Blob container name for Terraform state (3-24 chars). |
| `account_replication_type` | `string` | `LRS` | Data redundancy strategy (LRS, GRS, etc.). |
| `rg_location` | `string` | `australiasoutheast` | The Azure Region for the Resource Group. |
| `location` | `string` | `australiasoutheast` | The Azure Region for the storage resource. |
| `account_tier` | `string` | `Standard` | Performance tier (Standard/Premium). |
| `allow_public_network_access`| `bool` | `true` | Toggle for public network accessibility. |

---
