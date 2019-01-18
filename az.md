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

## List resize options


```
az vm list-vm-resize-options --resource-group djdsetest --name djdsetesta1 --output table
```
