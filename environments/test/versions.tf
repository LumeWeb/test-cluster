terraform {
  backend "s3" {
    key    = "test-cluster/terraform.tfstate"
    bucket = "lumeweb-test-cluster-devops"
    skip_credentials_validation = true
    skip_region_validation = true
    skip_metadata_api_check = true
  }
}