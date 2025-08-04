resource "azurerm_policy_definition" "single_dns_register" {
  name         = "priavte-single-dns-register"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Auto register private DNS zone for Private Endpoint"

  metadata = <<METADATA
    {
    "category": "Networking"
    }

METADATA


  policy_rule = <<POLICY_RULE
  {
    "if": {
      "allOf": [
        {
          "field": "type",
          "equals": "Microsoft.Network/privateEndpoints"
        },
        {
          "count": {
            "field": "Microsoft.Network/privateEndpoints/privateLinkServiceConnections[*]",
            "where": {
              "allOf": [
                {
                  "field": "Microsoft.Network/privateEndpoints/privateLinkServiceConnections[*].privateLinkServiceId",
                  "contains": "[parameters('privateLinkServiceId')]"
                },
                {
                  "field": "Microsoft.Network/privateEndpoints/privateLinkServiceConnections[*].groupIds[*]",
                  "equals": "[parameters('privateEndpointGroupId')]"
                }
              ]
            }
          },
          "greaterOrEquals": 1
        }
      ]
    },
    "then": {
      "effect": "[parameters('effect')]",
      "details": {
        "type": "Microsoft.Network/privateEndpoints/privateDnsZoneGroups",
        "roleDefinitionIds": [
          "/providers/Microsoft.Authorization/roleDefinitions/4d97b98b-1d4f-4787-a291-c67834d212e7"
        ],
        "deployment": {
          "properties": {
            "mode": "incremental",
            "template": {
              "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
              "contentVersion": "1.0.0.0",
              "parameters": {
                "privateDnsZoneId": {
                  "type": "string"
                },
                "privateEndpointName": {
                  "type": "string"
                },
                "location": {
                  "type": "string"
                }
              },
              "resources": [
                {
                  "name": "[concat(parameters('privateEndpointName'), '/deployedByPolicy')]",
                  "type": "Microsoft.Network/privateEndpoints/privateDnsZoneGroups",
                  "apiVersion": "2020-03-01",
                  "location": "[parameters('location')]",
                  "properties": {
                    "privateDnsZoneConfigs": [
                      {
                        "name": "[parameters('privateEndpointGroupId')]-privateDnsZone",
                        "properties": {
                          "privateDnsZoneId": "[parameters('privateDnsZoneId')]"
                        }
                      }
                    ]
                  }
                }
              ]
            },
            "parameters": {
              "privateDnsZoneId": {
                "value": "[parameters('privateDnsZoneId')]"
              },
              "privateEndpointName": {
                "value": "[field('name')]"
              },
              "location": {
                "value": "[field('location')]"
              }
            }
          }
        }
      }
    }
  }
POLICY_RULE


  parameters = <<PARAMETERS
  {
    "privateDnsZoneId": {
      "type": "String",
      "metadata": {
        "displayName": "Private DNS Zone Id",
        "description": "The private DNS zone to deploy in a new private DNS zone group and link to the private endpoint",
        "strongType": "Microsoft.Network/privateDnsZones"
      }
    },
    "privateEndpointGroupId": {
      "type": "String",
      "metadata": {
        "displayName": "Private Endpoint Group Id",
        "description": "A group Id for the private endpoint"
      }
    },
    "privateLinkServiceId": {
      "type": "String",
      "metadata": {
        "displayName": "Private LinkService Id",
        "description": "The ID of the private link service to link to the private endpoint (ex: Microsoft.DocumentDb/databaseAccounts)"
      }
    },
    "effect": {
      "type": "String",
      "metadata": {
        "displayName": "Effect",
        "description": "Enable or disable the execution of the policy"
      },
      "allowedValues": [
        "DeployIfNotExists",
        "Disabled"
      ],
      "defaultValue": "DeployIfNotExists"
    }
  }
PARAMETERS

}
