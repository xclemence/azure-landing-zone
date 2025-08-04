variable "identity_location" {
  type = string
}

variable "dns_zone_configs" {
  type = map(object({
    privateDnsZoneId       = string
    privateEndpointGroupId = string
    privateLinkServiceId   = string
  }))
}
