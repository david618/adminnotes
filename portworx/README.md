# Portworx 

## Remove Nodes from AKS

**WARNING:** There is a risk you'll lose data or corrupt Portworx in this process.  When we move to Cloud drives this will no longer be an issue.

### Find the highest node 

```
kubectl get nodes
```

Pick node with highest number suffix (e.g. 9)

### Drain the node 

```
kubectl drain --ignore-daemonsets=true --delete-local-data --force aks-nodepool1-17537833-9
```


### Enter Maintenance Mode

Exec into node you want to delete.

```
kubectl -n kube-system get pods -o wide | grep portworx
```

Verify "This node" is the one you want to take down.


```
/opt/pwx/bin/pxctl status  
```

Put node into Maintenance

```
/opt/pwx/bin/pxctl service maintenance --enter
```

### Delete Node

Exec into a node you are not deleting.

```
/opt/pwx/bin/pxctl list  
```

Node you want to delete should be in Maintenance mode.  Using ID delete.

```
/opt/pwx/bin/pxctl cluster delete  02166b89-8c56-40db-9806-16c1d0d949bf
```

### Scale AKS Down

Repeat the steps above for each node.  Be sure to remove nodes with highest suffixes.

Once done from Azure Portal scale the AKS down (e.g. 10 to 6).  AKS should remove the higher indexed nodes.


