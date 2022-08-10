resource "google_container_cluster" "cluster" {
  name               = "my-cluster"
  location           = "us-west1-a"
  project_id         = "burner-chamohan3"
  initial_node_count = 1
  provider = google-beta
}
