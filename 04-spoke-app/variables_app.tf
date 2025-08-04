variable "location" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "dns_zones" {
  type = map(object({
    id = string
  }))
}
