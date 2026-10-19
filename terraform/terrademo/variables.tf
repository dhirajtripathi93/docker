variable "bq_dataset_name" {
  description = "My BigQuery dataset name."
  default     = "demo_dataset"
}


variable "gcs_storage_class" {
  description = "Bucket storage class."
  default     = "STANDARD"
}

variable "location" {
  description = "Bucket location."
  default     = "US"
}

variable "gcs_bucket_name" {
  description = "Bucket name."
  default     = "terraform-demo-510809-terra-bucket"
}

variable "project" {
  description = "GCP project ID."
  default     = "terraform-demo-510809"
}

variable "credentials" {
  description = "Path to the GCP credentials JSON file."
  default     = "./keys/my-creds.json"
}
