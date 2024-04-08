locals {
  name = "${var.name_prefix}-${terraform.workspace}"
  
  gke_cluster_name = "${local.name}-cluster"
  gke_node_group_name = "${local.name}-ng"
  gke_sa_name = "${local.name}-sa"

  vpc_name = "${local.name}-vpc"
  vpc_subnet_name = "${local.name}-subnet"
  vpc_subnet_pod_range_name = "k8s-pod-range"
  vpc_subnet_svc_range_name = "k8s-svc-range"
  
  router_name = "${local.name}-router"
  nat_name = "${local.name}-nat"
}