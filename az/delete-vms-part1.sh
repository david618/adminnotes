#!/bin/bash

RG=djdsetest

for i in $(seq 101 140); do
  name=${RG}a${i}
  echo ${name}
  az vm delete --resource-group ${RG} --name ${name} --yes &
done
