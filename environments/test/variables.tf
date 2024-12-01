variable "renterd_seed" {
  description = "Seed phrase for renterd cluster"
  type        = string
  default     = ""
  sensitive   = true

  validation {
    condition     = length(var.renterd_seed) >= 8
    error_message = "Seed phrase must be at least 8 characters long."
  }
}

variable "renterd_password" {
  description = "API password for renterd cluster"
  type        = string
  default     = ""
  sensitive   = true

    validation {
        condition     = length(var.renterd_password) >= 8
        error_message = "API password must be at least 8 characters long."
    }
}

variable "renterd_worker_count" {
  description = "Number of worker nodes in the renterd cluster"
  type        = number
  default     = 1
}

variable "allowed_providers" {
  description = "List of allowed providers for renterd cluster"
  type        = list(string)
}

