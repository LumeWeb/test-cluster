resource "cloudflare_dns_record" "renterd_bus" {
  zone_id = var.domain_zone_id
  name    = module.renterd_cluster.bus.dns_fqdn
  content = module.renterd_cluster.bus.provider_host
  type    = "CNAME"
  ttl     = 1
}

resource "cloudflare_dns_record" "renterd_autopilot" {
  zone_id = var.domain_zone_id
  name    = module.renterd_cluster.autopilot.dns_fqdn
  content = module.renterd_cluster.autopilot.provider_host
  type    = "CNAME"
  ttl     = 1
}

resource "cloudflare_dns_record" "renterd_workers" {
  count = length(module.renterd_cluster.workers)
  zone_id = var.domain_zone_id
  name    = module.renterd_cluster.workers[count.index].dns_fqdn
  content = module.renterd_cluster.workers[count.index].provider_host
  type    = "CNAME"
  ttl     = 1
}