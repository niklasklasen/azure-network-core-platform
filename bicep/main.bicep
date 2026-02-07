targetScope = 'resourceGroup'

param subid string = '/subscriptions/2e63d2be-c58f-4c17-b08d-967891a03825'
param vnet1id string = '/subscriptions/2e63d2be-c58f-4c17-b08d-967891a03825/resourceGroups/rg-vnets/providers/Microsoft.Network/virtualNetworks/vnet-1'
param vnet2id string = '/subscriptions/2e63d2be-c58f-4c17-b08d-967891a03825/resourceGroups/rg-vnets/providers/Microsoft.Network/virtualNetworks/vnet-2'

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
        subid
      ]
    }
  }
}

resource networkgroup1 'Microsoft.Network/networkManagers/networkGroups@2025-05-01' = {
  parent: resavnm
  name: 'network-group-1'
  properties: {
    description: 'Network Group 1'
    memberType: 'VirtualNetwork'
  }
}

resource networkgroup2 'Microsoft.Network/networkManagers/networkGroups@2025-05-01' = {
  parent: resavnm
  name: 'network-group-2'
  properties: {
    description: 'Network Group 2'
    memberType: 'VirtualNetwork'
  }
}

resource staticMember1 'Microsoft.Network/networkManagers/networkGroups/staticMembers@2025-05-01' = {
  parent: networkgroup1
  name: 'static-member-vnet-1'
  properties: {
    resourceId: vnet1id
  }
}

resource staticMember2 'Microsoft.Network/networkManagers/networkGroups/staticMembers@2025-05-01' = {
  parent: networkgroup2
  name: 'static-member-vnet-2'
  properties: {
    resourceId: vnet2id
  }
}
