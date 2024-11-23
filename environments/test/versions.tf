terraform {
  backend "s3" {
    key    = "test-cluster/terraform.tfstate"
    bucket = "lumeweb-test-cluster-devops"
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
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "cloudflare" {
  api_token = "GkwcUCP1m9pWkK3GsxNhNig2nbtm5_WAuW6DZ1hL"
}