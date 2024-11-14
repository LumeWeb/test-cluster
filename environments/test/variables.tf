variable "RENTERD_SEED" {
  description = "Seed phrase for renterd cluster"
  type        = string
  default     = ""
  sensitive   = true

  validation {
    condition     = length(var.RENTERD_SEED) >= 8
    error_message = "Seed phrase must be at least 8 characters long."
  }
}

variable "RENTERD_PASSWORD" {
  description = "API password for renterd cluster"
  type        = string
  default     = ""
  sensitive   = true

    validation {
        condition     = length(var.RENTERD_PASSWORD) >= 8
        error_message = "API password must be at least 8 characters long."
    }
}