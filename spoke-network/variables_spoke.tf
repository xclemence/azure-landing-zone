variable "location" {
  type    = string
  default = "west europe"
}

variable "hub_dns_ip" {
  type = string
}


variable "vet_hub" {
  type = object({
    id                  = string
    name                = string
    resource_group_name = string
  })
}
