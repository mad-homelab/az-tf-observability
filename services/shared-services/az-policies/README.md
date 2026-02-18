# Service: Azure Policies (Governance)

## Purpose
This service automates platform-wide governance by enforcing **DeployIfNotExists (DINE)** policies. It ensures that both new and existing resources—such as Storage Accounts—are automatically brought into compliance with the enterprise's observability standards.

---

## What it creates
* **Policy Assignments**: Enforces built-in Azure Policies at the subscription level.
* **Managed Identities & RBAC**: Provisions the system-assigned identities and permissions (e.g., *Monitoring Contributor*) required for automated remediation.
* **Subscription Remediation**: Utilizes the `azurerm_subscription_policy_remediation` resource to trigger the fixing of existing non-compliant resources.

---

## Architecture & Components
This service follows a two-tier governance model:
1. **Internal Module (`module-policy-builtin`)**: Standardizes the assignment of the policy and the configuration of the Managed Identity.
2. **Root Configuration (`governance-main.tf`)**: Orchestrates the remediation lifecycle, ensuring the policy effect is applied retroactively across the subscription.



### Key Features
* **Retroactive Compliance**: By calling the remediation resource in the root, the service actively scans and fixes "monitoring blind spots" in resources that existed before the policy was applied.
* **Identity-Driven Governance**: Automates the creation of service principals with scoped RBAC, ensuring a "Secretless" and secure remediation process.
* **Decoupled Logic**: Separates the "Policy Definition" (what to check) from the "Remediation Logic" (how to fix), allowing for cleaner code and easier auditing.

---