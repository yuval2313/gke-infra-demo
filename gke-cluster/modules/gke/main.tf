data "google_compute_zones" "available" {
    status = "UP"
}

resource "google_container_cluster" "cluster" {
  name                     = "${var.name}-cluster"
  network                  = var.vpc_self_link
  subnetwork               = var.subnet_self_link
  networking_mode          = var.networking_mode
  description              = var.description
  deletion_protection      = false
    
  node_locations = var.is_zonal_cluster ? [var.cluster_zone] : data.google_compute_zones.available.names
  
  # See https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster#example-usage---with-a-separately-managed-node-pool-recommended
  remove_default_node_pool = true
  initial_node_count       = 1
  
  logging_service          = var.enable_logging_service ? "logging.googleapis.com/kubernetes" : "none"
  monitoring_service       = var.enable_monitoring_service ? "monitoring.googleapis.com/kubernetes" : "none"

  release_channel {
    channel = var.release_channel
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.cluster_secondary_range_name
    services_secondary_range_name = var.services_secondary_range_name
  }


  private_cluster_config {
    enable_private_nodes    = var.is_private_cluster
    enable_private_endpoint = false
    master_ipv4_cidr_block  = var.cluster_master_cidr
  }

  addons_config {
    gce_persistent_disk_csi_driver_config {
        enabled = true
    }
  }  
}

resource "google_container_node_pool" "main" {
  name       = "${var.name}-node-group"
  cluster    = google_container_cluster.cluster.id
  node_count = var.node_count

  management {
    auto_repair  = var.node_group_auto_repair
    auto_upgrade = var.node_group_auto_upgrade
  }

  node_config {
    machine_type = var.node_group_machine_type

    service_account = var.service_account_email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

