terraform {
  backend "s3" {
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_s3_checksum            = true
  }
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
  required_version = ">= 1.0"
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

/*module "remote_states" {
  source      = "../../modules/remote-state"
  component   = "core"
}
*/

data "terraform_remote_state" "remote_states" {
  backend = "s3"
  config = {
    bucket                      = var.aws_bucket
    key                         = "core/terraform.tfstate"
    skip_credentials_validation = true
    skip_region_validation     = true
    skip_metadata_api_check    = true
    skip_s3_checksum          = true
    use_path_style          = true
  }
}