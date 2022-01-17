resource "google_compute_address" "static" {
  name = "ipv4-address"
}

resource "google_compute_autoscaler" "foobar" {
  name   = "my-autoscaler"
  zone   = "europe-west1-b"
  target = google_compute_instance_group_manager.foobar.id

  autoscaling_policy {
    max_replicas    = 5
    min_replicas    = 1
    cooldown_period = 60

    cpu_utilization {
      target = 0.5
    }
    load_balancing_utilization {
      target = 0.5
    }
  }
}

resource "google_compute_instance_template" "foobar" {
  name           = "my-instance-template"
  machine_type   = "e2-micro"
  can_ip_forward = false
  metadata_startup_script = file("install_apache.sh")

  tags = ["foo", "bar"]

  disk {
    source_image = data.google_compute_image.debian_9.id
  }

  network_interface {
    network = "vpc-network"
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  metadata = {
    foo = "bar"
  }
  service_account {
    email = ["deploymentautoscaler@internal-interview-candidates.iam.gserviceaccount.com"]
    scopes = ["cloud-platform"]
  }

}

resource "google_compute_target_pool" "foobar" {
  name = "my-target-pool"
}

resource "google_compute_instance_group_manager" "foobar" {
  name = "my-igm"
  zone = "europe-west1-b"

  version {
    instance_template  = google_compute_instance_template.foobar.id
    name               = "primary"
  }

  target_pools       = [google_compute_target_pool.foobar.id]
  base_instance_name = "foobar"
}

data "google_compute_image" "debian_9" {
  family  = "debian-9"
  project = "debian-cloud"
}
