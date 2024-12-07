output "mysql_cluster" {
  description = "MySQL cluster details"
  value = {
    master   = module.mysql_cluster.master
    replicas = module.mysql_cluster.slaves
    info     = module.mysql_cluster.cluster_info
  }
}

output "proxysql" {
  description = "ProxySQL details"
  value = {
    endpoint    = "${module.proxysql.provider_host}:${module.proxysql.port}"
    admin_port  = module.proxysql.admin_port
    state      = module.proxysql.state
  }
}

output "renterd" {
  description = "Renterd cluster details"
  value = {
    bus = {
      endpoint = module.renterd_cluster.bus.dns_fqdn
      state   = module.renterd_cluster.bus.state
    }
    workers = module.renterd_cluster.workers
    autopilot = {
      endpoint = module.renterd_cluster.autopilot.dns_fqdn
      state   = module.renterd_cluster.autopilot.state
    }
  }
}
