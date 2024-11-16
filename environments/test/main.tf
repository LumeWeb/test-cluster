module "renterd_cluster" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/compute/renterd-cluster?ref=develop"

  environment = "test"
  base_domain = "test.local"

  # Fetch secrets from environment variables
  seed = sensitive(coalesce(var.renterd_seed, "test-seed"))
  bus_api_password = sensitive(coalesce(var.renterd_password, "test-password"))
  worker_api_password = sensitive(coalesce(var.renterd_password, "test-password"))

  # Configure single worker
  worker_count = var.renterd_worker_count

  # Minimal resource allocation for testing
  bus_cpu_cores    = 1
  bus_memory_size  = 1
  bus_storage_size = 60

  worker_cpu_cores   = 1
  worker_memory_size = 1
  worker_storage_size = 10

  # Allowed providers for deployment
  allowed_providers = var.allowed_providers
}
