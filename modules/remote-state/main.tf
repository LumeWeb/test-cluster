data "terraform_remote_state" "component" {
  backend = "s3"
  config = {
    bucket = env("AWS_BUCKET")
    key                         = "${var.component}/terraform.tfstate"
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true
    force_path_style            = true
  }
}