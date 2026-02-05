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

<<<<<<< HEAD
data "azurerm_client_config" "current" {
}

=======
>>>>>>> 2b6fb42 (update template)
resource "azurerm_resource_group" "rg" {
  name     = "rg-avnm-demo"
  location = "swedencentral"
}

<<<<<<< HEAD
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
=======
resource "azapi_resource" "avnm" {
  type = "Microsoft.Network/networkManagers@2022-09-01"
  name = "avnm-demo"
  parent_id = azurerm_resource_group.rg.id
  location = azurerm_resource_group.rg.location
  body = jsonencode({
    properties = {
      description = "Terraform created Azure Virtual Network Manager"
>>>>>>> 2b6fb42 (update template)
      networkManagerScopeAccesses = [
        "Connectivity",
      ]
      networkManagerScopes = {
        managementGroups = [
        ]
        subscriptions = [
<<<<<<< HEAD
          data.azapi_resource.subscription.id,
=======
          "/subscriptions/2e63d2be-c58f-4c17-b08d-967891a03825",
>>>>>>> 2b6fb42 (update template)
        ]
      }
    }
  })
<<<<<<< HEAD
  schema_validation_enabled = false
  response_export_values    = ["*"]
}

resource "azapi_resource" "virtualNetwork-1" {
  type      = "Microsoft.Network/virtualNetworks@2024-10-01"
  parent_id = azurerm_resource_group.rg.id
  name      = "vnet-tf-demo-1"
  location  = "swedencentral"
  body = jsonencode({
    properties = {
      addressSpace = {
        addressPrefixes = [
          "10.0.1.0/24",
        ]
      }
      dhcpOptions = {
        dnsServers = [
        ]
      }
      subnets = [
      ]
    }
  })
  schema_validation_enabled = false
  response_export_values    = ["*"]
}

resource "azapi_resource" "networkGroup" {
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

resource "azapi_resource" "staticMember" {
  type      = "Microsoft.Network/networkManagers/networkGroups/staticMembers@2024-10-01"
  parent_id = azapi_resource.networkGroup.id
  name      = "static-member-vnet-1"
  body = jsonencode({
    properties = {
      resourceId = azapi_resource.virtualNetwork-1.id
    }
  })
  schema_validation_enabled = false
  response_export_values    = ["*"]
=======
}

resource "azapi_resource" "network-group-1" {
  type = "Microsoft.Network/networkManagers/networkGroups@2022-09-01"
  name = "network-group-1"
  parent_id = azapi_resource.avnm.id
  body = jsonencode({
    properties = {
      description = "Network Group 1"
      memberType = "VirtualNetworks"
    }
  })
}

resource "azapi_resource" "network-group-2" {
  type = "Microsoft.Network/networkManagers/networkGroups@2022-09-01"
  name = "network-group-2"
  parent_id = azapi_resource.avnm.id
  body = jsonencode({
    properties = {
      description = "Network Group 2"
      memberType = "VirtualNetworks"
    }
  })
>>>>>>> 2b6fb42 (update template)
}