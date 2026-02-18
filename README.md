# Azure-Terraform Observability

## The What and the Why
The goal of this project is to implement a production-grade, automated observability framework that maximizes the business value of the Azure Monitor platform. By treating observability as code, we ensure that the entire stack—from cloud platform and networking to IaaS and PaaS workloads—is governed by proactive telemetry standards. This project ensures consistent observability coverage across the Azure ecosystem. By using policy-driven remediation and automated resource deployment with built-in observability features, we eliminate "monitoring blind spots" with minimum manual intervention, ensuring that platform health and compliance risk indicators are always captured and visible.

---

## Architecture and Operating Model

### Architecture Diagram
The architecture utilizes a **Decoupled Governance Pattern**. A centralized GitHub Actions pipeline orchestrates deployments across different service domains, ensuring that observability logic is separated from core infrastructure but enforced globally at the subscription level.

### Teams and Services
The repository is structured to support a multi-team environment through **Service Isolation**:
* **Shared Services Team**: Manages bootstrap resources, including the initial Resource Groups and Storage Accounts for every team.
* **Observability Team**: Owns the centralized Log Analytics Workspace and reusable Terraform modules to deploy observability components such as Data Collection Rules (DCRs), alert rules, and action groups.
* **Workload Teams**: Consume these pre-governed services to ensure their specific apps (IaaS/PaaS) are compliant upon deployment.

### Tech Stack
* **Infrastructure Deployment**: **Terraform utilizing** a modularized structure.
* **CI/CD**: **GitHub Actions** with path-based triggers and OIDC-based Azure authentication.
* **Enforcement**: Azure Policy (DeployIfNotExists), Azure Monitoring & Dependency Agents, Application Insights SDKs, and Terraform module deployment of alert rules and action groups for automated observability enablement.
* **Observability & Monitoring**: Azure Monitor, Log Analytics (LAW), Data Collection Rules, VM Insights, and Application Insights.

---

## Design Decisions

### Security (OIDC)
The project utilizes OpenID Connect (OIDC) to establish federated identity between GitHub Actions and Azure. This eliminates the need for long-lived secrets, aligning with enterprise security standards for platform automation.

### Shared State Storage
Implements a hierarchical state strategy where a centralized backend is used for bootstrapping shared services. To ensure autonomy and isolation, individual teams manage their own backend state storage for their specific environments. To eliminate the risk of long-lived secrets, all backend access is "keyless." By establishing **OIDC Federated Credentials** between GitHub Actions and Azure, the pipeline authenticates using short-lived tokens. Permissions are strictly enforced via **RBAC** (Storage Blob Data Contributor), ensuring a "Secretless" security posture that adheres to the Principle of Least Privilege.

### Resources and Modularized Components by Owner

#### Shared Services and Bootstrapping Services
* [Backend State Provisioning Engine](services/shared-services/backend-state-provisioning/README.md) - Automates the lifecycle of team-specific Resource Groups and Storage Accounts (Backend State Storage).
* [Resource Group](modules/resource-group/README.md) - Standardized resource container for service lifecycle management.
* [Storage Account](modules/state-storage/README.md) - Deploys storage accounts to store each service's respective backend state; configured with keyless state access via OIDC and RBAC.
* [Storage Account Diagnostics and Platform Metrics](services/shared-services/az-policies/README.md) - Enables Storage Account Diagnostics and Platform Metrics via Azure Built-in Policy

#### Observability Core
* [Log Analytics Workspace](services/observability-core/log-analytics-workspace/README.md) - Deploys centralised log analytics workspace resource.
* (Coming soon) Data Collection Rule- Logic for telemetry ingestion and filtering.
* (Coming soon) Log-based Alert Rule - Build standardised log-based alerts using performant KQL queries and alert rule configurations.
* (Coming soon) Metric-based Alert Rule - Deploy alert rules based on available metrics (Platform/Guest OS)
* (Coming soon) Application Insights - Enable full-stack, code-level application visibility.

---

## Key Outcomes – Full-Stack Azure-Native Observability

### Centralized Log Analytics
We deployed a Central Log Analytics Workspace as the primary and unified telemetry sink. Configuration includes optimised retention periods to balance operational requirements with cost-efficiency.

*(Screenshot to be placed here)*

### Storage Account Diagnostic Settings and Platform Metrics via Azure Policy
Automated enablement of diagnostic settings for Storage Accounts using Azure Policy (DeployIfNotExists) to ensure platform metrics are captured automatically across the subscription.

*(Before and after remediation screenshots to be placed here)*

### (Coming soon) IaaS Workload
* **VM AMA and Dependency agents via policy**: Automated deployment of the Azure Monitor Agent and Dependency Agent to enable VM Insights at scale.
* **AppInsights integration**: Deep application-level monitoring for IaaS-hosted services.

### (Coming soon) PaaS Workload
* **Diagnostic Settings and Platform Metrics for PaaS Resource**: Extending policy-driven governance to Azure PaaS services.
* **AppInsights**: Native integration of Application Insights SDKs for serverless and managed services.

### (Coming soon) Network Connection Monitor
Proactive monitoring of network connectivity and latency across cloud-native environments.

### (Coming soon) Azure Workbooks – Single Pane of Glass
Creation of interactive operational dashboards in Azure Workbooks to present health, performance, compliance posture, and platform risk indicators.

---

### SRE Alignment
This project directly supports SRE-driven practices by reducing operational toil through automated compliance enforcement and ensuring that application telemetry data is available to build reliable and resilient systems by driving down Mean-Time-To-Detect & Mean-Time-To-Resolve and establishing SLO and Error Budget tracking.