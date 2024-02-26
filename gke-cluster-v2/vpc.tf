resource "google_compute_project_default_network_tier" "default" {
  network_tier = var.vpc_network_tier
}

module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 9.0"

    project_id   = var.g_project
    network_name = local.vpc_name
    delete_default_internet_gateway_routes = true

    subnets = [
      {
        subnet_name           = local.vpc_subnet_name
        subnet_ip             = var.vpc_subnet_primary_range
        subnet_region         = var.g_region
        subnet_private_access = "true"
      }
    ]

    secondary_ranges = {
      "${local.vpc_subnet_name}" = [
        {
          range_name    = local.vpc_subnet_pod_range_name
          ip_cidr_range = var.vpc_subnet_pod_range
        },
        {
          range_name    = local.vpc_subnet_svc_range_name
          ip_cidr_range = var.vpc_subnet_svc_range
        }
      ]
    }

    routes = [
        {
            name                   = "egress-internet"
            description            = "route through IGW to access internet"
            destination_range      = "0.0.0.0/0"
            next_hop_internet      = "true"
        }
    ]
}