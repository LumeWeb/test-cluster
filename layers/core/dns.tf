resource "cloudflare_dns_record" "renterd" {
  zone_id = var.domain_zone_id
  name    = module.renterd.dns_fqdn
  content = module.renterd.provider_host
  type    = "CNAME"
  ttl     = 1
}