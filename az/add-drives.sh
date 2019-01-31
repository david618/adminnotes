#!/bin/bash

RG=MC_dj0129_dj0129-cluster_westus2

for node in $(az vm list -g ${RG} | jq --raw-output .[].name | grep aks); do
  echo ${node}
  az vm disk attach -g ${RG} --vm-name ${node} --disk ${node}d1 --new --size-gb 2048 > ${node}.out 2>&1 &
done
