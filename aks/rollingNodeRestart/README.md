
## Rolling Restart AKS Nodes

Lessons learned when trying to do a rolling restart of AKS nodes.  The following is the findings trying three different approaches.

**Bottom Line:** Based on the following results Drain/Restart is the best.

### Kubectl Commands

- Check Node Status: ``kubectl get nodes -o wide``
- List all pods: ``kubectl get pods -o wide --all-namespaces | grep aks-nodepool1-42717744-4``

### Restart 

Restarted From Azure Portal
- The node stopped and restarted after about 3 minutes
- Some pods showed errors for another couple of minutes (feeds seem to take longest)
- In pod list the some pods did not show any restart and AGE was still several days; however, pods seemed ok
  - Could exec into the pod
  - For Elasticsearch pod; curl localhost:9200 responded as expected

### Stop/Wait/Start

#### Stop/Wait

Stopped Node from Azure Portal
- After about 3-5 minutes pods restarted on other nodes
- Some of the pods were still listed with STATUS "Unknown" for the pod that was stopped

#### Start

Started Node from Azure Portal
- The pods with status "Unknown" were no longer listed

**Note:** At one point the kubectl command started responding very slowly taking over a minute for any query.

### Drain/Restart

#### Drain
```
kubectl drain --ignore-daemonsets=true --delete-local-data --force aks-nodepool1-42717744-4
```
- Couple of minutes after running drain all pods were moved to other nodes
- Node listed as ``Ready/SchedulingDisabled`` 

#### Restart
- During restart status changed to ``NotReady/SchedulingDisabled`` for a minute
- Then back to ``Ready/SchedulingDisabled`` 

#### Uncordon
```
kubectl uncordon aks-nodepool1-42717744-4
```
Status back to Ready







