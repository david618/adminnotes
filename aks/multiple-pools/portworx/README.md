## Portworx on AKS


### Add Nodes 

When you scale AKS up the additional nodes will get Portworx installed; but they will not be data nodes.

The following steps can be used to make them data nodes.


#### Add Drives

Added two new nodes; then used this command to add disks.

```
az vm disk attach -g MC_dj0430k_dj0430k-cluster_westus2 --vm-name aks-nodepool1-33881288-4 --name aks-nodepool1-33881288-4d1 --new --size-gb 1024
az vm disk attach -g MC_dj0430k_dj0430k-cluster_westus2 --vm-name aks-nodepool1-33881288-5 --name aks-nodepool1-33881288-5d1 --new --size-gb 1024
```

#### Find and Delete the new Portworx Pods

```
kubectl get pods -n kube-system -o wide | grep portworx
```

```
kubectl -n kube-system delete pod portworx-czh8l
kubectl -n kube-system delete pod portworx-g75nw
```


#### Add Drives to Portworx

Find the new pod names

```
kubectl get pods -n kube-system -o wide | grep portworx
```

Exec into each pod

```
kubectl -n kube-system exec -it portworx-689dc bash
```

```
/opt/pwx/bin/pxctl status  
```

Note the drive space for (This node)

Find the dev name (e.g. ls -l /dev/sd*).

Look for disk with no partitions.

/dev/sdc exists but no partitions (e.g. /dev/sdc1)

```
/opt/pwx/bin/pxctl service maintenance --enter
```

Once it's in maintenance mode

```
/opt/pwx/bin/pxctl service drive add --drive /dev/sdc --operation start

/opt/pwx/bin/pxctl service drive add --drive /dev/sdc --operation status

/opt/pwx/bin/pxctl service maintenance --exit
```

```
/opt/pwx/bin/pxctl status
```

You should more space that wasn't there before.
