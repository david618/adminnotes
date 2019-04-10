

## Testing Multiple Node Pools AKS

Using document provided by Azure "Preview ‐ Create and manage multiple node pools for a cluster in Azure Kubernetes Service ﴾AKS﴿.pdf"


### Required Update to Azure CLI

Requires: 2.0.61

```
az --version 
```

Showed my current version 2.0.60

Azure CLI [Install Instructions](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-macos?view=azure-cli-latest)

```
brew update
brew upgrade azure-cli
```

Notes:
- Install got Stuck for 10+ mins on "Pouring azure-cli-2.0.61.mojave.bottle.tar.gz"
- Eventually gave up and restarted.  (Ctrl-C to stop)
- After another couple of mins the install completed.  


### Added AKS-PREVIEW

```
az extension add --name aks-preview
az feature register --name MultiAgentpoolPreview --namespace Microsoft.ContainerService
az feature register --name VMSSPreview --namespace Microsoft.ContainerService
```

**WARN:** The PDF in the example commands has some extra dashes.

```
az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/MultiAgentpoolPreview')].{Name:name,State:properties.state}"
az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/VMSSPreview')].{Name:name,State:properties.state}"
```

**WARN:** Document says aks-preview should only be used in test and development; not production.  No way to unregister.

### Create Resource Group
