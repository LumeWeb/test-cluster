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
}