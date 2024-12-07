variable "cloudflare_api_token" {
  type = string
  sensitive = true
}

variable "allowed_providers" {
  description = "List of allowed providers"
  type = list(string)
  default = []
}

variable "base_domain" {
  description = "Base domain for DNS records"
  type = string
  default = "test-node.testing.pinner.xyz"
}

variable "etcd_root_password" {
  description = "Root password for etcd"
  type = string
  sensitive = true
}

variable "mysql_root_password" {
  description = "Root password for MySQL"
  type = string
  sensitive = true
}

variable "renterd_api_password" {
  description = "API password for Renterd"
  type = string
  sensitive = true
}

variable "renterd_seed" {
  description = "Seed for Renterd wallet"
  type = string
  sensitive = true
}

variable "environment" {
  description = "Deployment environment"
  type = string
  default = "dev"
}

variable "domain_zone_id" {
  description = "Cloudflare zone ID for DNS records"
  type = string
}

variable "metrics_password" {
  description = "Password for metrics"
  type = string
  sensitive = true
}