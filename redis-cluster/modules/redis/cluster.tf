resource "google_network_connectivity_service_connection_policy" "redis" {
  name = "${var.name}-scp"
  
  location = var.g_region
  service_class = "gcp-memorystore-redis"
  description   = "Memorystore Redis cluster service connection policy"
  network = var.vpc_id
  
  psc_config {
    subnetworks = var.subnet_ids
  }
}

resource "google_redis_cluster" "cluster" {
  name = "${var.name}-cluster"
  depends_on = [google_network_connectivity_service_connection_policy.redis]

  region = var.g_region
  shard_count = var.shard_count
  replica_count = var.replica_count
  
  authorization_mode = var.authorization_mode
  transit_encryption_mode = var.transit_encryption_mode

  psc_configs {
    network = var.vpc_id
  }
}