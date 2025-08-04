variable "location" {
  type    = string
  default = "west europe"
}

variable "private_dns_zones" {
  type        = map(string)
  description = "Map of private DNS zone names to create (key = alias, value = zone name)"
}
