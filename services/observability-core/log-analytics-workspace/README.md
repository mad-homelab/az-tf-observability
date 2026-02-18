# Log Analytics Workspace

## Purpose
This service establishes the **Central Log Analytics Workspace (LAW)**, serving as the primary regional telemetry sink for the entire Azure ecosystem. It provides the data foundation for automated observability, performance tuning, and SRE-driven reliability practices.

---

## What it creates
* **Log Analytics Workspace**: A centralized regional repository for all telemetry data.
* **Standardized Retention Policies**: Configured data retention settings to balance visibility with cost-efficiency.
* **Resource-Based Access Control**: Configured to support resource-context-based access.

---

## Architecture & Components
Managed by the **Observability Team** as a shared platform service, it aggregates logs from IaaS, PaaS, and Networking components into a single "Source of Truth".

### Key Features
* **Resource-Context Access**: Enables workload teams to view logs only for the specific resources they own, providing granular security without administrative overhead.
* **Telemetry Consolidation**: Serves as the endpoint for **Azure Policies (DINE)**, **Azure Monitoring Agents**, and **Application Insights** that automatically send diagnostics and telemetry across the subscription.
* **Keyless Deployment**: Orchestrated via **GitHub Actions** using **OIDC** and **keyless backend state storage**, ensuring a secretless CI/CD pipeline.

---

## Coming Soon
* **Granular/Tabular Retention Settings**: Implementation of table-level retention overrides. This will allow for longer retention on security-critical logs (e.g., `SecurityEvent`) while maintaining shorter, cost-optimized retention for high-volume operational telemetry (e.g., `AppMetrics`).

---