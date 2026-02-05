targetScope = 'resourceGroup'

resource resavnm 'Microsoft.Network/networkManagers@2025-05-01' = {
  location: resourceGroup().location
  name: 'avnm-demo'
  properties: {
    description: 'Bicep created Azure Virtual Network Manager'
    networkManagerScopeAccesses: [
      'Connectivity'
    ]
    networkManagerScopes: {
      subscriptions: [
        '2e63d2be-c58f-4c17-b08d-967891a03825'
      ]
    }
  }
}

resource networkgroup1 'Microsoft.Network/networkManagers/networkGroups@2025-05-01' = {
  parent: resavnm
  name: 'network-group-1'
  properties: {
    description: 'Network Group 1'
    memberType: 'VirtualNetworks'
  }
}

resource networkgroup2 'Microsoft.Network/networkManagers/networkGroups@2025-05-01' = {
  parent: resavnm
  name: 'network-group-2'
  properties: {
    description: 'Network Group 2'
    memberType: 'VirtualNetworks'
  }
}
