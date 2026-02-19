# Azure-Native Observability: Enterprise Governance Framework

> **⚠️ Portfolio Note:** This repository demonstrates a reference architecture for **deploying observability at-scale**. It illustrates the architectural patterns I utilize to enforce governance, security, and consistent telemetry across complex Azure environments. It is designed to showcase best practices for policy-driven monitoring and is not an exact replica of any specific corporate implementation.

## 🎯 The What and the Why
The goal of this project is to implement a production-grade, automated observability framework that maximizes the business value of the Azure Monitor platform. By treating observability as code, we ensure that the entire stack—from cloud platform and networking to IaaS, PaaS, and Data workloads—is governed by proactive telemetry standards.

This project addresses the common challenge of "monitoring drift" in large environments. By using **Policy-Driven Remediation** and automated resource deployment, we eliminate blind spots with zero manual intervention, ensuring that platform health and compliance indicators are always captured and visible.

---

## 🏗️ Architecture and Operating Model

### The Decoupled Governance Pattern
The architecture utilizes a **Decoupled Governance Pattern**. A centralized GitHub Actions pipeline orchestrates deployments across different service domains, ensuring that observability logic is separated from core infrastructure but enforced globally at the subscription level.

### Service Isolation Model
The repository is structured to support a multi-team enterprise environment:
*   **Shared Services Team:** Manages bootstrap resources, including the initial Resource Groups and Storage Accounts (State).
*   **Observability Team:** Owns the centralized Log Analytics Workspace (LAW) and reusable Terraform modules to deploy DCRs (Data Collection Rules), alert rules, and action groups.
*   **Workload Teams:** Consume these pre-governed services to ensure their specific apps (IaaS/PaaS/Data) are compliant upon deployment.

### Tech Stack
*   **Infrastructure:** Terraform (Modular HCL).
*   **CI/CD:** GitHub Actions with path-based triggers.
*   **Security:** OpenID Connect (OIDC) for identity federation (Zero Trust).
*   **Enforcement:** Azure Policy (`DeployIfNotExists`), Azure Monitor Agents (AMA).

## 📁 Repo Reference

To explore the underlying Infrastructure-as-Code (IaC) implementation, navigate through the core components below:

| Component | Responsibility | Technical Documentation |
| :--- | :--- | :--- |
| **Resource Group Module** | Standardized resource group deployment and tagging. | [Module README](modules/resource-group/README.md) |
| **State Storage Module** | Reusable module for secure, secretless backend storage. | [Module README](modules/state-storage/README.md) |
| **Backend Provisioning** | Orchestration of the Terraform remote state infrastructure. | [Provisioning README](services/shared-services/backend-state-provisioning/README.md) |
| **Observability Core** | Deployment of the centralized Log Analytics Workspace. | [LAW README](services/observability-core/log-analytics-workspace/README.md) |
| **Governance Engine** | Centralized Azure Policy (`DINE`) and Remediation logic. | [AzPolicy README](services/shared-services/az-policies/README.md) |

---

## 🔒 Design Decisions

### Security (OIDC & Zero Trust)
The project utilizes **OpenID Connect (OIDC)** to establish federated identity between GitHub Actions and Azure. This eliminates the need for long-lived secrets, aligning with enterprise-grade security standards for platform automation.

### Secretless Shared State
Implements a hierarchical state strategy where a centralized backend is used for bootstrapping shared services. To eliminate the risk of credential theft:
*   All backend access is **"keyless."**
*   The pipeline authenticates using short-lived OIDC tokens.
*   Permissions are strictly enforced via **RBAC** (Storage Blob Data Contributor).

---

## 📊 Key Outcomes: Full-Stack Visibility `(Active Development)`
This framework is designed to provide visibility beyond standard IaaS, covering the entire enterprise stack:

### 1. Centralized Log Analytics (The Hub)
Deployed a Central Log Analytics Workspace as the primary telemetry sink. Configuration includes **optimized retention policies** to balance operational requirements with cost-efficiency.

### 2. Infrastructure (IaaS) Governance
*   **Automated Agent Injection:** Uses Azure Policy to automatically deploy the **Azure Monitor Agent (AMA)** and Dependency Agent to all new VMs.
*   **Drift Detection:** Ensures no server can exist in the environment without reporting telemetry.

### 3. Application Performance (PaaS)
*   **Code-Level Visibility:** Architects the native integration of **Application Insights** (OpenTelemetry) for App Services and Functions.
*   **Distributed Tracing:** Enables end-to-end transaction tracing across microservices, moving visibility beyond "uptime" to "latency diagnostics."

### 4. Data Pipeline Reliability (Azure Data Factory)
*   **Pipeline Failure Detection:** Defines a standard monitoring pattern for **Azure Data Factory** to enforce consistent logging via Azure Policy.
*   **The "Why":** To prevent silent failures in ETL jobs. The architecture is designed to stream 100% of `PipelineRun` logs to the central workspace, enabling SREs to build "Freshness Alerts" (e.g., *'Alert if the 4 AM Regulatory Report is late'*) without relying on manual configuration.

### 5. Network Resilience
*   **Connection Monitors:** Establishes a pattern for proactive **Azure Network Watcher** Connection Monitors.
*   **Traffic Analysis:** Designed to continuously test connectivity to critical endpoints (e.g., License Servers, Gateways) to detect blocking NSG rules before they impact applications.

---

## 🗺️ Implementation Plan: Full-Stack Azure-Native Observability

### Phase 1: Foundation (Completed)
*   [x] OIDC Security Setup & Secretless State
*   [x] Centralized Log Analytics Workspace Deployment
*   [x] Storage Account Diagnostics via Policy (`DeployIfNotExists`)

### Phase 2: Workload Insights (Planned)
*   **IaaS Module:** Standardization of Alert Rules and Action Groups for VM fleets.
*   **PaaS Module:** Native integration of Application Insights SDKs for App Service and Functions.
*   **Data Reliability Module:** Standardization of alert logic for **Azure Data Factory**, focusing on "Failed Runs" and "Long Running Pipelines."

### Phase 3: Visual Intelligence (Planned)
*   **Azure Workbooks:** Creation of "Single Pane of Glass" dashboards to visualize health, compliance posture, and platform risk indicators (SLIs/SLOs).

---

## 👤 About
**Maintained by:** Aiso Dee
*Senior Observability Engineer & Architect*
```