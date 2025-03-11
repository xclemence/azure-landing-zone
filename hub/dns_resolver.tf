resource "azurerm_private_dns_resolver" "main" {
  name                = "europe-dns-resolver"
  resource_group_name = azurerm_resource_group.hub.name
  location            = azurerm_resource_group.hub.location
  virtual_network_id  = azurerm_virtual_network.hub.id
}

resource "azurerm_private_dns_resolver_outbound_endpoint" "main" {
  name                    = "main-endpoint"
  private_dns_resolver_id = azurerm_private_dns_resolver.main.id
  location                = azurerm_private_dns_resolver.main.location
  subnet_id               = azurerm_subnet.outbound_dns.id
}

resource "azurerm_private_dns_resolver_inbound_endpoint" "main" {
  name                    = "main-inbound-endpoint"
  private_dns_resolver_id = azurerm_private_dns_resolver.main.id
  location                = azurerm_private_dns_resolver.main.location

  ip_configurations {
    private_ip_allocation_method = "Dynamic"
    subnet_id                    = azurerm_subnet.inbounddns.id
  }
}

resource "azurerm_private_dns_resolver_dns_forwarding_ruleset" "main" {
  name                                       = "main-ruleset"
  resource_group_name                        = azurerm_resource_group.hub.name
  location                                   = azurerm_resource_group.hub.location
  private_dns_resolver_outbound_endpoint_ids = [azurerm_private_dns_resolver_outbound_endpoint.main.id]
}


resource "azurerm_private_dns_resolver_virtual_network_link" "main" {
  name                      = "main-link"
  dns_forwarding_ruleset_id = azurerm_private_dns_resolver_dns_forwarding_ruleset.main.id
  virtual_network_id        = azurerm_virtual_network.hub.id
}
