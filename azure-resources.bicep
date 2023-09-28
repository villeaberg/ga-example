
param location string = 'westus3'
param storageName string = 'newubuntudrive'

param namePrefix string = 'villeaberg'

param dockerImage string = 'ubuntu/nginx'
param dockerImageTag string = 'latest'

targetScope = 'resourceGroup'

//how to cosume moduels
module storage 'modules/storage.bicep' = {
  name: storageName
  params: {
    storageName:storageName
    location: location
  }
}

module appPlanDeploy 'modules/servicePlan.bicep' = {
  name: '${namePrefix}-appPlanDeploy'
  params: {
    namePrefix: namePrefix
    location: location


  }
}

module deployWebsite 'modules/webApp.bicep' = {
  name: '${namePrefix}-deploy-website'
  params: {
    appPlanId: appPlanDeploy.outputs.planId
    location: location
    dockerImage: dockerImage
    dockerImageTag: dockerImageTag
  }
}

output siteUrl string = deployWebsite.outputs.siteUrl




/*  param location string = 'westus3'
param storageName string = 'xyzgastorage'

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: storageName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Premium_LRS'
  }
}
*/
