variable "RENTERD_SEED" {
  description = "Seed phrase for renterd cluster"
  type        = string
  default     = ""
  sensitive   = true
}

variable "RENTERD_PASSWORD" {
  description = "API password for renterd cluster"
  type        = string
  default     = ""
  sensitive   = true
}