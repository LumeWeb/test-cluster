output "bus_host" {
  description = "Host address of the bus node"
  value       = module.renterd_cluster.bus_host
}

output "worker_hosts" {
  description = "Host addresses of the worker nodes"
  value       = module.renterd_cluster.worker_hosts
}

output "autopilot_host" {
  description = "Host address of the autopilot node"
  value       = module.renterd_cluster.autopilot_host
}
output "bus_fqdn" {
  description = "Fully Qualified Domain Name for the bus node"
  value       = module.renterd_cluster.bus_dns_fqdn
}

output "worker_fqdns" {
  description = "Fully Qualified Domain Names for the worker nodes"
  value       = module.renterd_cluster.worker_dns_fqdns
}

output "autopilot_fqdn" {
  description = "Fully Qualified Domain Name for the autopilot node"
  value       = module.renterd_cluster.autopilot_dns_fqdn
}
