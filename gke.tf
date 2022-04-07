# GKE cluster
resource "google_container_cluster" "primary" {
  name     = "${var.project_id}-${var.cluster_name}-gke"
  // Specify a regional [var.region] or zonal [var.zone] cluster (for demo & testing use zonal to save resources)
  location   = var.zone
  
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  network_policy {
    enabled   = true
    provider  = "CALICO"
  }

  addons_config {
    // Enable network policy (Calico) as an addon.
    network_policy_config {
      disabled = false
    }
  }
  enable_binary_authorization = true
  enable_intranode_visibility = true
  enable_shielded_nodes = true
  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.cluster_name}-gke-node-pool"
 
 // Specify a regional [var.region] or zonal [var.zone] cluster (for demo & testing use zonal to save resources)
  location   = var.zone
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_num_nodes
  
  autoscaling {
    min_node_count = 5
    max_node_count = 10
  }

  node_config {
    service_account = "gke-sa@panwlabs-prisma-cloud.iam.gserviceaccount.com"
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    labels = {
      env = var.project_id
    }

    # preemptible  = true
    machine_type = "n1-standard-1"
    tags         = ["gke-node", "${var.project_id}-${var.cluster_name}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
