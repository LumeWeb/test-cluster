locals {
  cloudflare_zone_id = "594c7058710c206292951980b32a4881"
  
  # Database passwords for testing
  mysql_root_password = "test-password-123"
  mysql_repl_password = "test-password-456" 
  mysql_admin_password = "test-password-789"
  etcd_password = local.etcd_password
}
/*
module "renterd_cluster" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/compute/renterd-cluster?ref=develop"
  #source = "../../terraform-modules/modules/compute/renterd-cluster"

  image = "ghcr.io/lumeweb/akash-renterd:develop"

  environment = "test"
  base_domain = "node-test.testing.pinner.xyz"

  # Fetch secrets from environment variables
  seed = sensitive(coalesce(var.renterd_seed, "test-seed"))
  bus_api_password = sensitive(coalesce(var.renterd_password, "test-password"))
  worker_api_password = sensitive(coalesce(var.renterd_password, "test-password"))
  metrics_password = sensitive(coalesce("test-password"))

  # Configure single worker
  worker_count = var.renterd_worker_count

  # Minimal resource allocation for testing
  bus_cpu_cores    = 2
  bus_memory_size  = 4

  worker_cpu_cores   = 1
  worker_memory_size = 1

  # Allowed providers for deployment
  allowed_providers = var.allowed_providers
  placement_attributes = {
    lumeweb = "true"
  }

  enable_ssl = false
}

resource "cloudflare_record" "renterd_bus" {
  zone_id = local.cloudflare_zone_id
  name    = module.renterd_cluster.bus_dns_fqdn
  content   = module.renterd_cluster.bus_host
  type    = "CNAME"
  ttl     = 1
}

resource "cloudflare_record" "renterd_workers" {
  count   = var.renterd_worker_count
  zone_id = local.cloudflare_zone_id
  name    = module.renterd_cluster.worker_dns_fqdns[count.index]
  content   = module.renterd_cluster.worker_hosts[count.index]
  type    = "CNAME"
  ttl     = 1
}

resource "cloudflare_record" "renterd_autopilot" {
  zone_id = local.cloudflare_zone_id
  name    = module.renterd_cluster.autopilot_dns_fqdn
  content   = module.renterd_cluster.autopilot_host
  type    = "CNAME"
  ttl     = 1
}*/

module "etcd" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/coordination/etcd?ref=develop"
  environment = "test"

  root_password = sensitive(coalesce( "test-password"))

  allowed_providers = var.allowed_providers
  placement_attributes = {
    lumeweb = "true"
  }
}

module "mysql_cluster" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/db/mysql-cluster?ref=develop"

  cluster_name = "test-cluster"
  replica_count = 2

  root_password = sensitive(local.mysql_root_password)
  repl_password = sensitive(local.mysql_repl_password)

  etcd_endpoints = ["${module.etcd.provider_host}:${module.etcd.port}"]
  etcd_password = "test-password"

  metrics_enabled = true

  allowed_providers = var.allowed_providers
  
  master_placement_attributes = {
    lumeweb = "true"
  }
  
  replica_placement_attributes = {
    lumeweb = "true"
  }
}

module "proxysql" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/db/proxysql?ref=develop"

  name = "test-proxy"
  admin_password = sensitive(local.mysql_admin_password)

  etcd_endpoints = ["${module.etcd.provider_host}:${module.etcd.port}"]
  etcd_password = local.etcd_password

  allowed_providers = var.allowed_providers
}
