variable "apikey" {
  description = "constellix api key"
  type        = string
  sensitive   = true
}

variable "secretkey" {
  description = "constellix api key"
  type        = string
  sensitive   = true
}

variable "records" {
  type = map(any)
}

variable "pools" {
  type = map(any)
}

variable "name" {
  description = "constellix api key"
  type        = string
}

variable "domain_id" {
  description = "constellix api key"
  type        = string
}