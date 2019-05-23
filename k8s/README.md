## Kubernetes 


### Delete Pods in Completed or Error Status

```
kubectl delete pod $(kubectl get pods | grep " Completed " | cut -d" " -f 1)
```

```
kubectl delete pod $(kubectl get pods | grep " Error " | cut -d " " -f 1)
```
