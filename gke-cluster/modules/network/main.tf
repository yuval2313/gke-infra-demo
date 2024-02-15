# network service tier
resource "google_compute_project_default_network_tier" "default" {
  network_tier = var.network_tier
}

# vpc
resource "google_compute_network" "vpc_network" {
  name                    = "${var.name}-vpc"
  auto_create_subnetworks = false
}

locals {
  subnet_k8s_pod_range_name = "k8s-pod-range"
  subnet_k8s_svc_range_name = "k8s-svc-range"
}

# cluster subnet
resource "google_compute_subnetwork" "subnet" {
  name                     = "${var.name}-cluster-subnet"
  region                   = var.g_region
  network                  = google_compute_network.vpc_network.id
  private_ip_google_access = var.is_private_subnet ? true : false
  
  ip_cidr_range = var.subnet_primary_cidr

  secondary_ip_range {
    range_name    = local.subnet_k8s_pod_range_name
    ip_cidr_range = var.subnet_k8s_pod_cidr
  }
  secondary_ip_range {
    range_name    = local.subnet_k8s_svc_range_name
    ip_cidr_range = var.subnet_k8s_svc_cidr
  }
}

# cloud router
resource "google_compute_router" "router" {
  count   = var.is_private_subnet ? 1 : 0
  name    = "${var.name}-router"
  network = google_compute_network.vpc_network.id
  bgp {
    asn            = 64514
    advertise_mode = "CUSTOM"
  }
}

# NAT
resource "google_compute_router_nat" "nat" {
  count                              = var.is_private_subnet ? 1 : 0
  name                               = "${var.name}-nat"
  router                             = google_compute_router.router[0].name
  region                             = google_compute_router.router[0].region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name = google_compute_subnetwork.subnet.name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}

