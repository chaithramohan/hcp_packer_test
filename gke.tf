resource "google_container_cluster" "cluster" {
  name               = "my-cluster"
  location           = "us-west1-a"
  project            = var.project_id
  initial_node_count = 1
  provider = google-beta
}
