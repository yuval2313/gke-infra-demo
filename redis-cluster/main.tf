locals {
    prefixed_name = "${terraform.workspace}-${var.name}"

    api_services = [
        "networkconnectivity.googleapis.com", 
        "compute.googleapis.com", 
        "serviceconsumermanagement.googleapis.com", 
        "redis.googleapis.com", 
    ]
}

module "services" {
    source = "./modules/services"

    api_services = local.api_services
}

module "network" {
    source = "./modules/vpc"

    name = local.prefixed_name
    g_project = var.g_project
    g_region = var.g_region

    network_tier = var.network_tier
    vpc_cidr = var.vpc_cidr
    subnet_cidr_offset = var.subnet_cidr_offset
    public_subnet_count = var.public_subnet_count
    private_subnet_count = var.private_subnet_count
}

module "redis" {
    source = "./modules/redis"
    depends_on = [module.network, module.services]

    name = local.prefixed_name
    g_region = var.g_region
    
    vpc_id = module.network.vpc_module.network_id
    subnet_ids = module.network.vpc_module.subnets_ids

    shard_count = var.shard_count
    replica_count = var.replica_count
}