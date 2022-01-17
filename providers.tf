provider "google" {
  project = var.project_id
  region = var.region
}

terraform {
  backend "gcs" {
    bucket = "casestudy_state_bucket"
    prefix = "terraform/state"
  }
}
