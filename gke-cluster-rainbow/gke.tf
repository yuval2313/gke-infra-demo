module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"
  version = "31.1.0"

  project_id  = var.g_project
  name        = local.gke_cluster_name
  description = "Cluster provisioned as part of ${local.name} Terraform project."

  region   = var.g_region
  regional = var.gke_is_regional_cluster
  zones    = var.gke_cluster_zones

  enable_l4_ilb_subsetting = true
  deletion_protection      = false

  network           = var.vpc_network_name
  subnetwork        = var.vpc_subnet_name
  ip_range_pods     = var.vpc_subnet_pod_range_name
  ip_range_services = var.vpc_subnet_svc_range_name

  create_service_account = false
  service_account        = google_service_account.gke_sa.email

  logging_service                      = var.gke_enable_logging_service ? "logging.googleapis.com/kubernetes" : "none"
  monitoring_service                   = var.gke_enable_monitoring_service ? "monitoring.googleapis.com/kubernetes" : "none"
  monitoring_enable_managed_prometheus = var.gke_enable_managed_prometheus

  remove_default_node_pool = true
  node_pools = [
    {
      name         = local.gke_node_group_name
      machine_type = var.gke_node_group_machine_type
      autoscaling  = false
      node_count   = var.gke_node_count
      disk_type    = var.gke_node_group_disk_type
      disk_size_gb = var.gke_node_group_disk_size
      auto_repair  = true
      auto_upgrade = true
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
