output "hub_dns_ip" {
  value = azurerm_private_dns_resolver_inbound_endpoint.main.ip_configurations[0].private_ip_address
}


output "vet_hub" {
  value = {
    id                  = azurerm_virtual_network.hub.id
    name                = azurerm_virtual_network.hub.name
    resource_group_name = azurerm_virtual_network.hub.resource_group_name
  }
}

output "dns_zones" {
  value = {
    for zone_key, zone_name in var.private_dns_zones : 
    zone_key => {
      id   = azurerm_private_dns_zone.zones[zone_key].id
      name = azurerm_private_dns_zone.zones[zone_key].name
    }
  }
}
