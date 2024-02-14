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
  public_subnets_count = var.is_private_cluster ? 0 : 1
  private_subnets_count = var.is_private_cluster ? 1 : 0
}

module network {
  source = "./modules/network"  

  name = local.prefixed_name
  g_region = var.g_region
  network_tier = var.network_tier

  network_cidr_block = var.network_cidr_block
  subnet_cidr_offset = var.subnet_cidr_offset
  public_subnets_count = var.is_private_cluster ? 0 : 1
  private_subnets_count = var.is_private_cluster ? 1 : 0
}

module gke {
  source = "./modules/gke"
  depends_on = [google_project_service.compute, google_project_service.container, module.network]

  name = local.prefixed_name
  description = var.cluster_description

  vpc_self_link = module.network.vpc_self_link
  subnet_self_link = var.is_private_cluster ? module.network.private_subnets[0].self_link : module.network.public_subnets[0].self_link
  
  is_zonal_cluster = var.is_zonal_cluster
  cluster_zone = var.cluster_zone
  cluster_master_cidr = var.cluster_master_cidr
  
  node_count = var.node_count
  node_group_machine_type = var.node_group_machine_type
  
  node_group_auto_repair = var.node_group_auto_repair
  node_group_auto_upgrade = var.node_group_auto_upgrade
  
  logging_service = var.logging_service
  monitoring_service = var.monitoring_service
  enable_managed_prometheus = var.enable_managed_prometheus
}
