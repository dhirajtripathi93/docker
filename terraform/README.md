# Terraform GCP Infrastructure Setup

This repository contains Terraform configurations to provision core Google Cloud Platform (GCP) infrastructure for data engineering projects.

## Resources Provisioned
* **Google Cloud Storage (GCS) Bucket:** Configured with `STANDARD` storage class, uniform bucket-level access, and automated lifecycle management (deletes objects after 3 days; aborts incomplete multipart uploads after 1 day).
* **Google BigQuery Dataset:** A foundational dataset deployed in the US multi-region.

## Prerequisites
* [Terraform](https://developer.hashicorp.com/terraform/downloads) installed on your local machine or Codespace.
* A Google Cloud project with billing enabled.
* A GCP Service Account with appropriate roles (e.g., Storage Admin, BigQuery Admin).
* A Service Account JSON key downloaded to your local environment.

## Directory Structure
Ensure your project directory is organized as follows before execution. The `keys/` directory is intentionally excluded from version control to protect your credentials.

```text
terrademo/
├── main.tf
├── variables.tf
├── .gitignore
└── keys/
    └── my-creds.json
```

## Configuration (Variables)
Default values are set in `variables.tf`. You can override these by creating a `terraform.tfvars` file or passing them via the command line.

| Variable | Description | Default Value |
| :--- | :--- | :--- |
| `project` | Your GCP Project ID | `terraform-demo-510809` |
| `location` | Deployment location for GCS and BigQuery | `US` |
| `gcs_bucket_name` | Globally unique name for the GCS bucket | `terraform-demo-510809-terra-bucket` |
| `gcs_storage_class` | Storage class for the bucket | `STANDARD` |
| `bq_dataset_name` | Name of the BigQuery dataset | `demo_dataset` |
| `credentials` | Path to your GCP Service Account JSON key | `./keys/my-creds.json` |

## Execution Guide

**1. Set up authentication**
Create a `keys` directory and place your downloaded GCP JSON credential file inside it:
```bash
mkdir -p keys
# Move your service account JSON file into this folder and rename it to my-creds.json
```

**2. Initialize Terraform**
Download the necessary provider plugins (HashiCorp Google Provider v8.5.0):
```bash
terraform init
```

**3. Review the execution plan**
Verify the resources that Terraform will create:
```bash
terraform plan
```

**4. Apply the configuration**
Deploy the infrastructure to Google Cloud:
```bash
terraform apply
```
*(Type `yes` when prompted to confirm the deployment.)*

## Teardown
To prevent ongoing GCP billing charges when you are done, destroy the resources:
```bash
terraform destroy
```
*(Type `yes` when prompted to confirm the destruction.)*
