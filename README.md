# End-to-End Data Engineering Architecture

A centralized portfolio repository demonstrating end-to-end data engineering infrastructure developed through the DataTalksClub Data Engineering Zoomcamp. This repository bridges local containerized development, cloud infrastructure-as-code (IaC), and declarative workflow orchestration across Google Cloud Platform (GCP).

---

## 🏗️ System Architecture

The repository is organized into three decoupled, production-grade components that form a complete data ingestion and warehousing pipeline:

```
├── docker/        # Containerized development environments & localized data pipelines
├── terraform/     # Infrastructure as Code (IaC) provisioning GCP cloud resources
└── kestra/        # Declarative ELT workflow orchestration, backfilling & BigQuery upserts
```

```
       +-------------------------------------------------------+
       |                  Terraform (IaC)                      |
       |  - Provisions Google Cloud Storage (GCS) Buckets      |
       |  - Provisions Google BigQuery Analytical Datasets     |
       +---------------------------+---------------------------+
                                   |
                                   v
+-----------------------+   +-------------------------------------------------------+
|     Docker Core       |   |                     Kestra Engine                     |
| - Isolated Runtimes   |-->| - Declarative YAML Workflows                          |
| - PostgreSQL Staging  |   | - Parameterized Execution & Triggers                  |
| - Service Networking  |   | - Cloud Extraction -> GCS Ingestion -> BigQuery MERGE |
+-----------------------+   +-------------------------------------------------------+
```

---

## 📁 Repository Modules

### 1. [Docker Infrastructure (`/docker`)](./docker)
* **Local Containerization:** Manages isolated development environments and backend services via `docker-compose`.
* **Database Staging:** Provisions PostgreSQL containers with persistent volume mounts for local pipeline staging.
* **Network Isolation:** Configures custom Docker bridge networks to enable communication between data ingest scripts and databases.
* **LLM-Powered Anomaly Insights:** Integrates OpenAI and Anthropic APIs to inspect ingestion telemetry, detect data quality anomalies, and generate automated diagnostic summaries on irregular records.(https://github.com/dhirajtripathi93/docker/blob/main/docker/pipeline/AI_INSIGHTS.md)

### 2. [Terraform Cloud Infrastructure (`/terraform`)](./terraform)
* **Infrastructure as Code (IaC):** Declarative GCP infrastructure management using HashiCorp Configuration Language (HCL).
* **Storage Layer:** Provisions Google Cloud Storage (GCS) data lake buckets configured with automated lifecycle transition rules and uniform bucket-level access.
* **Analytical Warehouse:** Provisions and manages BigQuery analytical datasets with location-targeted configurations.
* **Lifecycle Automation:** Utilizes structured `variables.tf` parameterization to support repeatable `init`, `plan`, `apply`, and `destroy` workflows across environments.

### 3. [Kestra Orchestration Engine (`/kestra`)](./kestra)
* **Declarative Pipeline Management:** Directs end-to-end ELT workflows via declarative YAML definitions with built-in retries and execution logs.
* **Dynamic Parameterization:** Accepts runtime variables (target execution dates, datasets, table IDs) to enable workflow reusability across datasets.
* **Idempotent Data Ingestion:** Enforces data integrity during ad-hoc backfills by running pre-load staging table truncations to prevent duplicate records.
* **Production Upsert Operations:** Executes SQL `MERGE` statements (`WHEN NOT MATCHED THEN INSERT`) to load analytical data from GCS into Google BigQuery without primary key collisions.
* **Secret Management:** Securely connects to GCP using containerized Google Cloud Service Account credentials (`gcp-key.json`).

---

## 🚀 Execution & Verification

### Prerequisites
* **Docker & Docker Compose** installed locally or in a cloud workspace.
* **Terraform CLI** (v1.0+) installed.
* **Google Cloud SDK (`gcloud`)** and an active GCP Project with Billing enabled.
* A GCP Service Account key with Storage Admin and BigQuery Admin roles.

### Pipeline Deployment Steps

1. **Clone the Monorepo:**
   ```bash
   git clone [https://github.com/dhirajtripathi93/docker.git](https://github.com/dhirajtripathi93/docker.git) data-engineering-portfolio
   cd data-engineering-portfolio
   ```

2. **Provision GCP Infrastructure:**
   ```bash
   cd terraform
   terraform init
   terraform plan -out=tfplan
   terraform apply tfplan
   cd ..
   ```

3. **Deploy Containerized Orchestration:**
   ```bash
   cd kestra
   # Place your gcp-key.json and set up your .env configuration
   docker-compose up -d
   ```

4. **Monitor Workflows:**
   * Access the Kestra UI at `http://localhost:8080`.
   * Trigger the parameterized ingestion flows to stage source files into GCS and merge records into BigQuery.
