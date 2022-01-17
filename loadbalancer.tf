resource "google_compute_forwarding_rule" "default" {
  name                  = "website-forwarding-rule"
  port_range            = 80
  backend_service       = google_compute_region_backend_service.backend.id
}
resource "google_compute_region_backend_service" "backend" {
  name                  = "website-backend"
  load_balancing_scheme = "EXTERNAL"
  health_checks         = [google_compute_region_health_check.hc.id]
  backend {
    group           = google_compute_instance_group_manager.foobar.instance_group
  }
}
resource "google_compute_region_health_check" "hc" {
  name               = "check-website-backend"
  check_interval_sec = 1
  timeout_sec        = 1

  tcp_health_check {
    port = "80"
  }
}
