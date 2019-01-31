NAME=test1
RG=dj0129
MCRG=$(az aks list --resource-group ${RG} | jq --raw-output '.[0].nodeResourceGroup')


az network public-ip create \
    --resource-group ${MCRG} \
    --allocation-method Static \
    --name ${NAME}-ip 

VNET=$(az network vnet list -g ${MCRG} | jq --raw-output '.[0].name')
SUBNET=$(az network vnet list -g ${MCRG} | jq --raw-output '.[0].subnets[0].name')
NSG=$(az network vnet list -g ${MCRG} | jq --raw-output '.[0].subnets[0].networkSecurityGroup.id')

az network nic create \
    --resource-group ${MCRG} \
    --name ${NAME}nic \
    --vnet-name ${VNET} \
    --subnet ${SUBNET} \
    --public-ip-address ${NAME}-ip \
    --network-security-group ${NSG} 

az vm create \
    --resource-group ${MCRG} \
    --name ${NAME} \
    --image OpenLogic:CentOS:7.5:latest\
    --nics ${NAME}nic \
    --admin-username azureuser \
    --size Standard_D4_v3  \
    --nic ${NAME}nic \
    --os-disk-size-gb 100 \
    --ssh-key-value /Users/davi5017/az.pub
