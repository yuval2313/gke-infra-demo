resource "google_project_service" "compute" {
  disable_on_destroy = false
  service = "compute.googleapis.com"
}

resource "google_project_service" "container" {
  disable_on_destroy = false
  service = "container.googleapis.com"
}

locals {
  prefixed_name = "${terraform.workspace}-${var.name}"
}

module network {
  source = "./modules/network"  

  name = local.prefixed_name
  g_region = var.g_region
  network_tier = var.network_tier

  subnet_primary_cidr = var.subnet_primary_cidr
  subnet_k8s_pod_cidr = var.subnet_k8s_pod_cidr
  subnet_k8s_svc_cidr = var.subnet_k8s_svc_cidr
  is_private_subnet = var.is_private_cluster
}

module security {
  source = "./modules/security"

  name = local.prefixed_name
  g_project = var.g_project
}

module gke {
  source = "./modules/gke"
  depends_on = [google_project_service.compute, google_project_service.container, module.network]

  name = local.prefixed_name
  description = var.cluster_description
  is_private_cluster = var.is_private_cluster

  networking_mode = var.networking_mode
  vpc_self_link = module.network.vpc.self_link
  subnet_self_link = module.network.subnet.self_link
  cluster_secondary_range_name  = module.network.subnet_k8s_pod_range_name
  services_secondary_range_name = module.network.subnet_k8s_svc_range_name
  
  is_zonal_cluster = var.is_zonal_cluster
  cluster_zone = var.cluster_zone
  cluster_master_cidr = var.cluster_master_cidr
  
  enable_logging_service = var.enable_logging_service
  enable_monitoring_service = var.enable_monitoring_service
  enable_managed_prometheus = var.enable_managed_prometheus
  release_channel = var.release_channel

  service_account_email = module.security.service_account_email
  node_count = var.node_count
  node_group_machine_type = var.node_group_machine_type
  
  node_group_auto_repair = var.node_group_auto_repair
  node_group_auto_upgrade = var.node_group_auto_upgrade
}
