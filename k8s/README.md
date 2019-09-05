## Kubernetes 

### Watch Command

The linux watch command when running kubectl get pods doesn't work well.  Adding a clear redirected to /dev/null provides a clean output.

```
watch -n 5 "clear > /dev/null ;kubectl -n kube-system get pods"
```


### Delete Pods in Completed or Error Status

```
kubectl delete pod $(kubectl get pods | grep " Completed " | cut -d" " -f 1)
```

```
kubectl delete pod $(kubectl get pods | grep " Error " | cut -d " " -f 1)
```


### Delete all pvc's

```
kubectl delete pvc $(kubectl get pvc -o custom-columns=NAME:.metadata.name --no-headers)
```


### Resize PVC

The Storage Class needs to include

```
allowVolumeExpanstion: true
```

The Storage Backend also need to support this option.

Tried to create a custom storage class using Azure default and managed-premium that included this parameter; however, I still could not resize the pvc.

Added the parameter to Portworx StorageClass.  After making this change the pvc could be resized.

```
kubectl edit pvc datastore-elasticsearch-client-0
``` 

Changed the size (e.g. 100Gi to 200Gi).

After a few seconds the Volume changed.


