locals {
  name = "${var.name_prefix}-${terraform.workspace}"

  gke_cluster_name    = "${local.name}-cluster"
  gke_node_group_name = "${local.name}-ng"
  gke_sa_name         = "${local.name}-sa"
}
