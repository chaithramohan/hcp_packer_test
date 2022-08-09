provider "google" {
  project = var.project_id
  region = var.region
}

terraform {
  backend "gcs" {
    bucket = "acm-bucket"
    prefix = "terraform/state"
  }
}
