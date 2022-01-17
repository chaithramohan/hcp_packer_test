resource "google_compute_firewall" "rules" {
  name        = "my-firewall-rule"
  network     = "vpc-network"
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol  = "tcp"
    ports     = ["80", "8080", "1000-2000"]
  }

  source_ranges = ["0.0.0.0/0"]
}
