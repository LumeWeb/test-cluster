terraform {
  backend "s3" {
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_s3_checksum            = true
  }
}

terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "5.0.0-alpha1"
    }
    akash = {
      source = "registry.terraform.io/lumeweb/akash"
      version = "0.1.2"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
