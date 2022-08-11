resource "google_container_cluster" "cluster" {
  name               = "my-cluster"
  location           = "us-west1-a"
  project            = var.project_id
  initial_node_count = 2
  provider = google-beta
}
resource "google_gke_hub_membership" "membership" {
  membership_id = "my-membership"
  project       = var.project_id
  endpoint {
    gke_cluster {
      resource_link = "//container.googleapis.com/${google_container_cluster.cluster.id}"
    }
  }
  provider = google-beta
}
resource "google_gke_hub_feature" "feature" {
  name = "configmanagement"
  location = "global"
  provider = google-beta
  project  = var.project_id
}
resource "google_gke_hub_feature_membership" "feature_member" {
  location = "global"
  feature = google_gke_hub_feature.feature.name
  project = var.project_id
  membership = google_gke_hub_membership.membership.membership_id
  configmanagement {
    version = "1.12.1"
    config_sync {
      git {
       sync_repo = "https://github.com/chaithramohan/example-config-repo.git"
        sync_branch = "1.0.0"
   policy_dir = "foo-corp"
        secret_type = "none"
      }
    }
  }
  provider = google-beta
}
