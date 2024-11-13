variable "RENTERD_SEED" {
  description = "Seed phrase for renterd cluster"
  type        = string
  default     = ""
  sensitive   = true
}

variable "RENTERD_BUS_PASSWORD" {
  description = "API password for the bus node"
  type        = string
  default     = ""
  sensitive   = true
}

variable "RENTERD_WORKER_PASSWORD" {
  description = "API password for worker nodes"
  type        = string
  default     = ""
  sensitive   = true
}
