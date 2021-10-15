# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.project_id}-vpc2"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project_id}-subnet2"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
  log_config {
    aggregation_interval = "INTERVAL_15_MIN"
    flow_sampling        = 1
    metadata             = "INCLUDE_ALL_METADATA"
    metadata_fields      = []
  }
}