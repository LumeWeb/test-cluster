terraform {
  backend "s3" {
    key    = "test-cluster/terraform.tfstate"
    bucket = "lumeweb-test-cluster-devops"
  }
}