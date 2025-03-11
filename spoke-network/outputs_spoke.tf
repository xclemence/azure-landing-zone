output "subnet_id" {
  value = azurerm_subnet.spoke_default.id
}

output "dns_zone" {
  value = {
    name                = azurerm_private_dns_zone.spoke.name
    resource_group_name = azurerm_private_dns_zone.spoke.resource_group_name
  }
}

output "location" {
  value = var.location
}
