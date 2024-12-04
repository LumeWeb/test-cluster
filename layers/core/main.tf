module "etcd" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/coordination/etcd?ref=develop"

  name              = "etcd"
  allowed_providers = var.allowed_providers
  root_password     = var.etcd_root_password
  environment       = var.environment

  resources = {
    cpu = {
      cores = 1
    }
    memory = {
      size = 1
      unit = "Gi"
    }
    storage = {
      size = 1
      unit = "Gi"
    }
    persistent_storage = {
      size  = 1
      unit  = "Gi"
      class = "beta3"
    }
  }
}

/*module "mysql" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/db/mysql?ref=develop"

  name              = "mysql"
  allowed_providers = var.allowed_providers
  root_password     = var.mysql_root_password
  environment       = var.environment
  backups_enabled   =  false

  resources = {
    cpu = {
      cores = 2
    }
    memory = {
      size = 4
      unit = "Gi"
    }
    storage = {
      size = 10
      unit = "Gi"
    }
    persistent_storage = {
      size  = 20
      unit  = "Gi"
      class = "beta3"
    }
  }
}*/
/*
module "renterd" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/compute/renterd?ref=develop"

  allowed_providers = var.allowed_providers
  environment       = var.environment

  api_password = var.renterd_api_password
  seed         = var.renterd_seed

  metrics_password = var.metrics_password

  dns = {
    base_domain = var.base_domain
  }

  network = {
    http_port  = 80
    s3_port    = 80
    enable_ssl = false
  }

  database = {
    type           = "mysql"
    mysql_uri      = "mysql://${module.mysql.provider_host}:${module.mysql.port}"
    mysql_password = var.mysql_root_password
  }

  resources = {
    cpu = {
      cores = 2
    }
    memory = {
      size = 4
      unit = "Gi"
    }
    storage = {
      size = 1
      unit = "Gi"
    }
    persistent_storage = {
      size  = 100
      unit  = "Gi"
      class = "beta3"
    }
  }

  depends_on = [module.mysql]
}
*/