targetScope = 'resourceGroup'

param count int = 3
param location string = 'westeurope'
param adminUsername string = 'azureuser'
param sshPublicKey string

resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: '${resourceGroup().name}-vnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/8'
      ]
    }
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' = {
  parent: vnet
  name: '${resourceGroup().name}-vm-subnet'
  properties: {
    addressPrefix: '10.20.30.0/24'
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource symbolicname 'Microsoft.Compute/virtualMachines@2021-11-01' = [ for i in range(0, count): {
  name: 'vm-${i}'
  location: location
  properties: {
      networkProfile: {
        networkApiVersion: '2020-11-01'
        networkInterfaceConfigurations: [
          {
            name: 'vm-${i}-NIC'
            properties: {
              deleteOption: 'Delete'
              ipConfigurations: [
                {
                  name: 'vm-${i}-NIC-Conf'
                  properties: {
                    primary: true
                    privateIPAddressVersion: 'IPv4'
                    publicIPAddressConfiguration: {
                      name: 'vm-${i}-PIP'
                      properties: {
                        deleteOption: 'Delete'
                        publicIPAddressVersion: 'IPv4'
                        publicIPAllocationMethod: 'Static'
                      }
                    }
                    subnet: {
                      id: subnet.id
                    }
                  }
                }
              ]
              primary: true
            }
          }
        ]
      }
      hardwareProfile: {
        vmSize: 'Standard_DS2_v2'
      }
      osProfile: {
        adminUsername: adminUsername
        computerName: 'vm-${i}'
        linuxConfiguration: {
          disablePasswordAuthentication: true
          provisionVMAgent: true
          ssh: {
            publicKeys: [
              {
                keyData: sshPublicKey
                path: '/home/${adminUsername}/.ssh/authorized_keys'
              }
            ]
          }
        }
      }
    storageProfile: {
      imageReference: {
        offer: 'Oracle-Linux'
        publisher: 'Oracle'
        sku: 'ol84-lvm'
        version: 'latest'
      }
    }
  }
}]
