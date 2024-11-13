terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

module "renterd_cluster" {
  source = "../../terraform-modules/modules/compute/renterd-cluster"

  environment = "test"
  base_domain = "test.local"
  
  # Fetch secrets from environment variables
  seed              = sensitive(coalesce(var.RENTERD_SEED, "test-seed"))
  bus_api_password  = sensitive(coalesce(var.RENTERD_BUS_PASSWORD, "test-bus-password"))
  worker_api_password = sensitive(coalesce(var.RENTERD_WORKER_PASSWORD, "test-worker-password"))
  
  # Configure single worker
  worker_count = 1
  
  # Minimal resource allocation for testing
  bus_cpu_cores = 1
  bus_memory_size = 1
  bus_storage_size = 10
  
  worker_cpu_cores = 1
  worker_memory_size = 1
  worker_storage_size = 10
}
