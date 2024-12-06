# MySQL Cluster
module "mysql_cluster" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/db/mysql-cluster?ref=develop"

  cluster_name    = "mysql-${var.environment}"
  environment     = var.environment
  replica_count   = 1  # 1 replica = 2 total nodes
  
  root_password   = var.mysql_root_password
  repl_password   = var.mysql_repl_password

  # ETCD Configuration
  etc_endpoints = [var.etcd_endpoint]
  
  # Resource Configuration
  master_resources = {
    cpu_units    = 2
    memory_size  = 4
    storage_size = 20
  }

  replica_resources = {
    cpu_units    = 2
    memory_size  = 4
    storage_size = 20
  }

  allowed_providers = var.allowed_providers
}

# ProxySQL
module "proxysql" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/db/proxysql?ref=develop"

  name        = "proxysql-${var.environment}"
  environment = var.environment
  
  admin_password = var.proxysql_admin_password

  # Connect to ETCD
  etcd = {
    endpoints = [var.etcd_endpoint]
  }

  # Resource Configuration
  resources = {
    cpu = {
      cores = 1
    }
    memory = {
      size = 1
      unit = "Gi"
    }
    storage = {
      size = 10
      unit = "Gi"
    }
  }

  allowed_providers = var.allowed_providers

  depends_on = [module.mysql_cluster]
}

# Renterd Cluster
module "renterd_cluster" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/compute/renterd-cluster?ref=develop"

  environment = var.environment
  base_domain = var.base_domain
  
  # Authentication
  seed = var.renterd_seed
  bus_api_password = var.renterd_api_password
  worker_api_password = var.renterd_api_password
  metrics_password = var.renterd_metrics_password

  # MySQL Configuration via ProxySQL
  database = {
    type = "mysql"
    mysql_uri = "mysql://${module.proxysql.provider_host}:${module.proxysql.port}"
    mysql_password = var.mysql_root_password
  }

  # Resource Configuration
  bus_cpu_cores = 2
  bus_memory_size = 4
  bus_storage_size = 100
  
  worker_cpu_cores = 2
  worker_memory_size = 4
  worker_count = 2

  allowed_providers = var.allowed_providers

  depends_on = [module.proxysql]
}
