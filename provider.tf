terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.37.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
  subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" # Replace with your Azure subscription ID
}
