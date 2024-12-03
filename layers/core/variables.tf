variable "cloudflare_api_token" {
  type = string
  sensitive = true
}

variable "allowed_providers" {
  description = "List of allowed providers"
  type = list(string)
  default = []
}