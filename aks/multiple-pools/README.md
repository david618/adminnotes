

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

```
az group create --name dj0409mp --location westus2
```

### Create AKS



```
az aks create \
    --resource-group dj0409mp \
    --name dj0409mp-cluster \
    --enable-vmss \
    --node-count 3 \
    --node-vm-size Standard_D8s_v3 \
    --enable-addons monitoring \
    --admin-username azureuser \
    --ssh-key-value az.pub \
    --node-osdisk-size 100 \
    --kubernetes-version 1.12.7
```



With aks-preview extension added the ```az aks create`` failed on Linux after installation.

Removing the extension "az extension remove --name aks-preview"; allowed Linux to work again.

Note the extension worked from my Mac Book.

```
az aks nodepool add \
     --resource-group dj0409mp \
     --cluster-name dj0409mp-cluster \
     --name npds16 \
     --node-count 3 \
     --node-vm-size Standard_D16s_v3
```

```
kubectl get nodes
```

```
NAME                                STATUS   ROLES   AGE    VERSION
aks-nodepool1-65040137-vmss000000   Ready    agent   176m   v1.12.7
aks-nodepool1-65040137-vmss000001   Ready    agent   177m   v1.12.7
aks-nodepool1-65040137-vmss000002   Ready    agent   176m   v1.12.7
aks-npds16-65040137-vmss000000      Ready    agent   11m    v1.12.7
aks-npds16-65040137-vmss000001      Ready    agent   11m    v1.12.7
aks-npds16-65040137-vmss000002      Ready    agent   11m    v1.12.7
```



Looking at Portal Azure the nodepools are created as Virtual Machine Scale Sets.

You can't just add a public IP to one of these nodes. I added a boot node and from there I was able to ssh to the nodes using their private IP or the computer name.

Current install-portworx add's a drive to each node.  
- For scale sets you add to scale set and every instance in the scale set gets a new drive.
- You need to "Upgrade" the instances after adding the new drive for it to be created/attached

The remaining install scripts worked without change.

A4IOT was installed and worked.

## Adding GPU 

### List GPU Instance Types Available in region

```
az vm list-sizes --location westus2 --output table | grep Standard_N
```

### Add GPU Instnace

```
az aks nodepool add \
     --resource-group dj0409mp \
     --cluster-name dj0409mp-cluster \
     --name nc6sv3 \
     --node-count 1 \
     --node-vm-size Standard_NC6s_v3
```

Node pool added.

### Remove nodepool


```
az aks nodepool delete \
  --resource-group dj0409mp \
  --cluster-name dj0409mp-cluster \
  --name nc6sv3 \
  --no-wait
```

Node pool removed.

**NOTE:** We have not tested Omisci on Azure GPU's.  My assumption is it will work.
