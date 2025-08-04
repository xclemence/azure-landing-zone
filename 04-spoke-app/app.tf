# resource "azurerm_service_plan" "spoke_app" {
#   name                = "appplan-xce-test-01"
#   resource_group_name = azurerm_resource_group.spoke_app.name
#   location            = azurerm_resource_group.spoke_app.location
#   os_type             = "Linux"
#   sku_name            = "B1"
# }

# resource "azurerm_linux_web_app" "spoke_app" {
#   name                          = "app-xce-test-01"
#   location                      = azurerm_resource_group.spoke_app.location
#   resource_group_name           = azurerm_resource_group.spoke_app.name
#   service_plan_id               = azurerm_service_plan.spoke_app.id
#   public_network_access_enabled = false

#   https_only                 = true
#   client_certificate_enabled = false


#   identity {
#     type = "SystemAssigned"
#   }

#   site_config {
#     application_stack {
#       dotnet_version = "8.0"
#     }
#   }

#   app_settings = {
#     ApplicationInsightsAgent_EXTENSION_VERSION = "~3"
#     SCM_DO_BUILD_DURING_DEPLOYMENT             = false
#   }
# }


# resource "azurerm_private_endpoint" "spoke_app" {
#   name                = "pep-app-xce-test-01"
#   location            = azurerm_linux_web_app.spoke_app.location
#   resource_group_name = azurerm_linux_web_app.spoke_app.resource_group_name
#   subnet_id           = azurerm_subnet.spoke_default.id

#   private_service_connection {
#     name                           = "app-privateconnection"
#     private_connection_resource_id = azurerm_linux_web_app.spoke_app.id
#     subresource_names              = ["sites"]
#     is_manual_connection           = false
#   }
# }
