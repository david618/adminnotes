#!/bin/bash

RG=djdsetest


for i in $(seq 101 140); do
  name1=${RG}_a_data${i}
  echo ${name1}
  az disk delete --resource-group ${RG} --name ${name1} --yes &

  name2=${RG}a${i}
  echo ${name2}
  az disk delete --resource-group ${RG} --name ${name2} --yes &

  name3=${RG}_a${i}
  echo ${name2}
  az network nic delete --resource-group ${RG} --name ${name3} &

done
