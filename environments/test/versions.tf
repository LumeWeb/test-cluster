terraform {
  backend "s3" {
    key    = "test-cluster/terraform.tfstate"
    bucket = var.AWS_BUCKET
  }
}