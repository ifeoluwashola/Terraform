terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>5.19.0"
    }
  }
  backend "gcs" {
    bucket = ""
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# resource "google_service_account_iam_binding" "airflow_kubernetes_binding" {
#   service_account_id = "airflow-kubernetes@${var.project_id}.iam.gserviceaccount.com"
#   role               = "roles/iam.workloadIdentityUser"

#   members = [
#     "serviceAccount:${var.project_id}.svc.id.goog[airflow/airflow]"
#   ]
# }