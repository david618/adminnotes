
#!/bin/bash

RG=djdsetest


for i in $(seq 1 10); do
  name=${RG}a${i}
  echo ${name}
  az vm resize --resource-group ${RG} --name ${name} --size Standard_D32s_v3
done
