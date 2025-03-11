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

variable "spoke_dns_zone" {
  type = object({
    name                = string
    resource_group_name = string
  })
}
