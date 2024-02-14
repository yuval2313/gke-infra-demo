# network service tier
resource "google_compute_project_default_network_tier" "default" {
  network_tier = var.network_tier
}

# vpc
resource "google_compute_network" "vpc_network" {
  name                    = "${var.name}-vpc"
  auto_create_subnetworks = false
}

# public subnets
resource "google_compute_subnetwork" "public_subnets" {
  count         = var.public_subnets_count
  name          = "${var.name}-pub-subnet-${count.index}"
  region        = var.g_region
  network       = google_compute_network.vpc_network.id
  
  ip_cidr_range = cidrsubnet(var.network_cidr_block, var.subnet_cidr_offset, count.index)
}

# private subnets
resource "google_compute_subnetwork" "private_subnets" {
  count                    = var.private_subnets_count
  name                     = "${var.name}-priv-subnet-${count.index}"
  region                   = var.g_region
  network                  = google_compute_network.vpc_network.id
  private_ip_google_access = true
  
  ip_cidr_range = cidrsubnet(var.network_cidr_block, var.subnet_cidr_offset, count.index + var.public_subnets_count )
}

# cloud router
resource "google_compute_router" "router" {
  count   = var.private_subnets_count > 0 ? 1 : 0
  name    = "${var.name}-router"
  network = google_compute_network.vpc_network.id
  bgp {
    asn            = 64514
    advertise_mode = "CUSTOM"
  }
}

# NAT
resource "google_compute_router_nat" "nat" {
  count                              = var.private_subnets_count > 0 ? 1 : 0
  name                               = "${var.name}-nat"
  router                             = google_compute_router.router[0].name
  region                             = google_compute_router.router[0].region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  dynamic "subnetwork" {
    for_each = google_compute_subnetwork.private_subnets

    content {
      name = subnetwork.value["name"]
      source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
    }
  }
}

