# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~> 1.5.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {
}

variable "vnet-1-id" {
  type        = string
  default     = "/subscriptions/2e63d2be-c58f-4c17-b08d-967891a03825/resourceGroups/rg-vnets/providers/Microsoft.Network/virtualNetworks/vnet-1"
}

variable "vnet-2-id" {
  type        = string
  default     = "/subscriptions/2e63d2be-c58f-4c17-b08d-967891a03825/resourceGroups/rg-vnets/providers/Microsoft.Network/virtualNetworks/vnet-2"
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-avnm-demo"
  location = "swedencentral"
}

data "azapi_resource" "subscription" {
  type                   = "Microsoft.Resources/subscriptions@2021-01-01"
  resource_id            = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  response_export_values = ["*"]
}

resource "azapi_resource" "networkManager" {
  type      = "Microsoft.Network/networkManagers@2024-10-01"
  parent_id = azurerm_resource_group.rg.id
  name      = "avnm-tf-demo"
  location  = "swedencentral"
  body = jsonencode({
    properties = {
      description = ""
      networkManagerScopeAccesses = [
        "Connectivity",
      ]
      networkManagerScopes = {
        managementGroups = [
        ]
        subscriptions = [
          data.azapi_resource.subscription.id,
        ]
      }
    }
  })
  schema_validation_enabled = false
  response_export_values    = ["*"]
}

resource "azapi_resource" "networkGroup-1" {
  type      = "Microsoft.Network/networkManagers/networkGroups@2024-10-01"
  parent_id = azapi_resource.networkManager.id
  name      = "TF-NetworkGroup-1"
  body = jsonencode({
    properties = {
    }
  })
  schema_validation_enabled = false
  response_export_values    = ["*"]
}

resource "azapi_resource" "networkGroup-2" {
  type      = "Microsoft.Network/networkManagers/networkGroups@2024-10-01"
  parent_id = azapi_resource.networkManager.id
  name      = "TF-NetworkGroup-2"
  body = jsonencode({
    properties = {
    }
  })
  schema_validation_enabled = false
  response_export_values    = ["*"]
}

resource "azapi_resource" "staticMember-1" {
  type      = "Microsoft.Network/networkManagers/networkGroups/staticMembers@2024-10-01"
  parent_id = azapi_resource.networkGroup-1.id
  name      = "static-member-vnet-1"
  body = jsonencode({
    properties = {
      resourceId = var.vnet-1-id
    }
  })
  schema_validation_enabled = false
  response_export_values    = ["*"]
}