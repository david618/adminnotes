# az

Azure Command Line Interface

## Install


### CentOS

```
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
sudo yum -y install azure-cli
sudo yum -y install jq
```

## Login

```
az login
```

Follow directions on output.

## Resize VM

[Change Instance Type](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/change-vm-size)

```
az vm list-vm-resize-options --resource-group djdsetest --name djdsetesta1 --output table
```

Now resize

```
az vm resize --resource-group djdsetest --name djdsetesta1 --size Standard_D32_v3
```

**Note:** Tried on VM created by AKS; however, it failed with storage accounty type Premium_LRS is not supported.

## List 

```
az vm list-sizes --location eastus --output table
```

Grep to filter to just Standard_N

```
az vm list-sizes --location eastus --output table | grep Standard_N
```

## List Quota and Usage

```
az vm list-usage --location "East US 2" -o table
```

or 

```
az vm list-usage --location westus2 -o table | grep DSv3
```

Find Used and Limit for DSv3 

```
LOC=westus2
DSV3USED=$(az vm list-usage --location ${LOC} -o tsv |  awk -F'\t' '/DSv3/ {print $1}')
DSV3LIMIT=$(az vm list-usage --location ${LOC} -o tsv |  awk -F'\t' '/DSv3/ {print $2}')
DSV3AVAIL=$((${DSV3LIMIT}-${DSV3USED}))
echo "There are ${DSV3AVAIL} DSv3 cores available in ${LOC}"
```



