locals {
    public_subnets = [
        for i in range(var.public_subnet_count) :
            {
                subnet_name           = "${var.name}-pub-subnet-${i}"
                subnet_ip             = cidrsubnet(var.vpc_cidr, var.subnet_cidr_offset, i)
                subnet_region         = var.g_region
            }
    ]

    private_subnets = [
        for i in range(var.private_subnet_count) :
            {
                subnet_name           = "${var.name}-priv-subnet-${i}"
                subnet_ip             = cidrsubnet(var.vpc_cidr, var.subnet_cidr_offset, i + var.public_subnet_count) 
                subnet_region         = var.g_region
                subnet_private_access = "true"
            }
    ]

    nat_subnetworks = [
        for i in range(var.private_subnet_count) : 
            {
                name = local.private_subnets[i].subnet_name
                source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
                secondary_ip_range_names = []
            }
    ]
}

# network service tier
resource "google_compute_project_default_network_tier" "default" {
  network_tier = var.network_tier
}

module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 9.0"

    project_id   = var.g_project
    network_name = "${var.name}-vpc"
    delete_default_internet_gateway_routes = true

    subnets = concat(local.public_subnets, local.private_subnets)

    routes = [
        {
            name                   = "egress-internet"
            description            = "route through IGW to access internet"
            destination_range      = "0.0.0.0/0"
            next_hop_internet      = "true"
        }
    ]

    ingress_rules = [
        {
            name = "${var.name}-vpc-allow-ssh"
            description = "Allow SSH for tagged instances"
            priority = 1000
            source_ranges = ["0.0.0.0/0"]
            target_tags = ["allow-ssh"]

            allow = [
                {
                    protocol = "TCP"
                    ports = ["22"]
                }
            ]
        }
    ]
}

module "cloud-nat" {
  source     = "terraform-google-modules/cloud-nat/google"
  version    = "~> 5.0"
  project_id = var.g_project
  region     = var.g_region
  
  network = module.vpc.network_name
  create_router = true
  router = "${var.name}-router"
  name = "${var.name}-nat"

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetworks = local.nat_subnetworks
}