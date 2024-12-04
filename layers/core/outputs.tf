output "etcd_endpoint" {
  description = "ETCD service endpoint"
  value = module.etcd.service.endpoints[0]
}

output "mysql_endpoint" {
  description = "MySQL service endpoint"
  value = "${module.mysql.provider_host}:${module.mysql.port}"
}

output "renterd_endpoint" {
  description = "Renterd service endpoint"
  value = module.renterd.dns_fqdn
}

output "service_states" {
  description = "Current state of all services"
  value = {
    etcd = module.etcd.deployment.state
    mysql = module.mysql.deployment_id
    renterd = module.renterd.id
  }
}
