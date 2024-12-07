variable "environment" {
  description = "Environment name (e.g. dev, staging, prod)"
  type        = string
  default = "dev"
}

variable "allowed_providers" {
  description = "List of allowed Akash provider addresses"
  type        = list(string)
}

# MySQL Configuration
variable "mysql_root_password" {
  description = "MySQL root password"
  type        = string
  sensitive   = true
}

variable "mysql_repl_password" {
  description = "MySQL replication password"
  type        = string
  sensitive   = true
}

# ProxySQL Configuration
variable "proxysql_admin_password" {
  description = "ProxySQL admin password"
  type        = string
  sensitive   = true
}

# Renterd Configuration
variable "renterd_seed" {
  description = "Seed for renterd instances"
  type        = string
  sensitive   = true
}

variable "renterd_api_password" {
  description = "API password for renterd instances"
  type        = string
  sensitive   = true
}

variable "renterd_metrics_password" {
  description = "Password for renterd metrics"
  type        = string
  sensitive   = true
}
variable "cloudflare_api_token" {
  type = string
  sensitive = true
}
variable "domain_zone_id" {
  description = "Cloudflare zone ID for DNS records"
  type = string
}
variable "aws_bucket" {
  description = "AWS S3 bucket for backups"
  type = string
}