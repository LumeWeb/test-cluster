resource "cloudflare_dns_record" "renterd" {
  zone_id = var.domain_zone_id
  name    = module.renterd.dns_fqdn
  content = module.renterd.provider_host
  type    = "CNAME"
  ttl     = 1
}

resource "cloudflare_dns_record" "renterd_s3" {
  zone_id = var.domain_zone_id
  name    = module.renterd.s3_fqdn
  content = module.renterd.provider_host
  type    = "CNAME"
  ttl     = 1
}