module "renterd_cluster" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/compute/renterd-cluster?ref=develop"

  environment = "test"
  base_domain = "test.local"
  
  # Fetch secrets from environment variables
  seed              = sensitive(coalesce(var.RENTERD_SEED, "test-seed"))
  bus_api_password  = sensitive(coalesce(var.RENTERD_PASSWORD, "test-password"))
  worker_api_password = sensitive(coalesce(var.RENTERD_PASSWORD, "test-password"))
  
  # Configure single worker
  worker_count = 1
  
  # Minimal resource allocation for testing
  bus_cpu_cores = 1
  bus_memory_size = 1
  bus_storage_size = 60
  
  worker_cpu_cores = 1
  worker_memory_size = 1
  worker_storage_size = 10
}
