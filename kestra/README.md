# Data Engineering Workflow Orchestration with Kestra

This repository contains my data pipeline orchestration project built as part of the DataTalksClub Data Engineering Zoomcamp. It focuses entirely on building, scheduling, and monitoring Extract, Load, and Transform (ELT) workflows using Kestra, moving data securely into Google Cloud Platform (GCP).

## 🛠️ Tech Stack & Infrastructure

* **Orchestration:** Kestra (Declarative YAML workflows)
* **Containerization:** Docker & Docker Compose
* **Data Lake:** Google Cloud Storage (GCS)
* **Data Warehouse:** Google BigQuery

## 🚀 Key Features & Skills Demonstrated

* **Declarative Pipeline Design:** Built dependency-driven data workflows using Kestra's YAML structure to handle task execution, retries, and error logging.
* **Cloud Data Integration:** Automated the extraction of source data, staged it efficiently in **GCP Storage Buckets**, and loaded it into structured **BigQuery tables** for analytics.
* **Historical Backfilling & Scheduling:** Configured Kestra **Triggers** to automate the pipeline on a set schedule and successfully executed large-scale backfills of historical data.
* **Local Containerized Deployment:** Spun up the complete Kestra UI, execution engine, and underlying PostgreSQL backend locally using `docker-compose` for an isolated, reproducible environment.
* **GCP Credential Management:** Securely handled Google Cloud Service Account keys by mapping environment variables and Docker volumes to authenticate Kestra tasks with GCP services.

## 🔍 Deep Dive: The Kestra Workflow Logic

The core of this project is a highly robust, production-ready Kestra flow designed for idempotency and data integrity. Key pipeline behaviors include:

* **Dynamic Parameterization:** The workflow is fully parameterized, accepting user inputs at runtime (such as execution dates, dataset variables, and table names). This allows the exact same pipeline YAML to be reused dynamically across different datasets or specific historical backfill windows.
* **Pre-Load Truncation (Idempotency):** To ensure safe reruns and prevent duplicate records during backfills or failures, the pipeline automatically executes table truncation logic to clear target staging areas before initiating a fresh load.
* **Intelligent Upserts (Merge on No Match):** Moving data into the final production tables relies on optimized SQL `MERGE` statements. The workflow evaluates incoming data against existing records, cleanly inserting new rows only when there is no match, thereby preventing primary key conflicts and ensuring data accuracy.

## 📂 Repository Structure

* `flows/` - Contains the Kestra YAML workflow definitions outlining the parameterized extraction, GCS upload, and BigQuery loading/merging logic.
* `docker-compose.yaml` - The configuration file used to stand up the local Kestra orchestration environment.
* `.env` - Environment variable configurations for mapping secrets and host machine ports.

## 🏃‍♂️ Getting Started

### Prerequisites
* Docker and Docker Compose installed.
* A Google Cloud Project with Cloud Storage and BigQuery enabled.
* A GCP Service Account JSON key with the necessary read/write permissions.

### Running the Orchestration Locally
1. **Clone the repository:**
   ```bash
   git clone [https://github.com/dhirajtripathi93/kestra.git](https://github.com/dhirajtripathi93/kestra.git)
   cd kestra
   ```
2. **Configure Credentials:**
   * Ensure your GCP Service Account JSON key (`gcp-key.json`) is securely placed and mapped in your `.env` or `docker-compose.yaml` file so the Kestra container can authenticate with Google Cloud.
3. **Start the Environment:**
   ```bash
   docker-compose up -d
   ```
4. **Access the Kestra UI:**
   * Open your browser and navigate to `http://localhost:8080`.
   * From the UI, you can view the loaded flows, input custom parameters for a manual run, monitor scheduled backfills, and inspect the logs for the GCS to BigQuery ELT process.
