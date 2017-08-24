# VBoxManage

Command line management of Virtual Box VM's.

Online help for [VBoxManage](https://www.virtualbox.org/manual/ch08.html)

## List VMs
<pre>
$ VBoxManage list vms

"portal" {8e9ac0c1-022c-4e00-b92f-e0b60a2b6102}
"ags" {8c37a086-e12c-4bea-8a30-73903ed2b0df}
"ags2" {7068abac-7af3-428e-bfc2-6b0804dfddac}
"ds1" {d8b10011-a5f1-40bd-a3d5-ccd3576eb0b8}
"ds2" {e209595b-d33d-4827-b15f-8817c618f0e7}
"ds3" {78b85493-afea-4713-a3aa-10f370be920e}
</pre>

## Show VM Details
<pre>
$ VBoxManage showvminfo {8e9ac0c1-022c-4e00-b92f-e0b60a2b6102}
</pre>

## Find VM's and show Groups

<pre>
$ for a in $(VBoxManage list vms | cut -d ' ' -f 2 | xargs)
do
    GRP=$(VBoxManage showvminfo $a | grep Groups)
    echo "$a,$GRP"
done
</pre>

## Script to Get Names for Group

**NOTE:** Set VMGRP. Start with slash and end with $.  The name of the Group the VM's are in.

<pre>
#!/bin/bash

VMGRP="/CentOS7_105$"
for a in $(VBoxManage list vms | cut -d ' ' -f 2 | xargs); 
do
    NM=$(VBoxManage showvminfo ${a} | grep ^Name | cut -d ':' -f 2 | tr -d '[:space:]')    
    GRP=$(VBoxManage showvminfo ${a} | grep ^Groups | grep ${VMGRP})
    if [ ! -z "${GRP}" ]; then
        echo "${NM} ${a}"
    fi
done
</pre>

## Power off VM
<pre>
$ VBoxManage  controlvm {8e9ac0c1-022c-4e00-b92f-e0b60a2b6102} acpipowerbutton
</pre>

## Create Variable vms with my VMs

**NOTE:** After -d is two single quotes not a double quote.

<pre>
$ read -d '' vms << EOF
"portal" {8e9ac0c1-022c-4e00-b92f-e0b60a2b6102}
"ags" {8c37a086-e12c-4bea-8a30-73903ed2b0df}
"ags2" {7068abac-7af3-428e-bfc2-6b0804dfddac}
"ds1" {d8b10011-a5f1-40bd-a3d5-ccd3576eb0b8}
"ds2" {e209595b-d33d-4827-b15f-8817c618f0e7}
"ds3" {78b85493-afea-4713-a3aa-10f370be920e}
EOF
</pre>

List them

<pre>
$ echo "$vms"
</pre>

## Extract VM ids

**NOTE:** After -d is two single quotes with a space between not a double quote.

<pre>
$ vmids=$(echo "$vms" | cut -d ' ' -f 2)

$ echo "$vmids"
</pre>

## Power off VMs
<pre>

$ for vmid in $vmids
do
    VBoxManage  controlvm $vmid acpipowerbutton
done
</pre>

## Create Snapshot of VMs "base"

<pre>
$ for vmid in $vmids
do
    VBoxManage snapshot $vmid take base --description "Base Install ArcGIS 10.5"
done
</pre>

## Start VMs

<pre>
$ for vmid in $vmids
do
    VBoxManage startvm $vmid --type headless
done
</pre>

## Restore VMs to Snapshot "base"
<pre>
$ for vmid in $vmids
do
    VBoxManage snapshot $vmid restore base
done
</pre>

## Control VM Script

Create a file with the VM's.

<pre>
cat dcos_vms.txt
m1 {c3263537-6195-4b91-91ab-ca5e42b7ded9}
p1 {52646b04-7401-4360-a417-9d9ab96d901c}
a1 {fc6e55e7-9ad0-4e98-963c-da87411e4072}
a2 {d54ef809-72a7-4322-a5a2-aa01474d61e8}
a3 {2be366a0-af37-4c1b-8776-87b44b3fc2a6}
boot {1542eb74-bb65-4b14-b409-e9904b64454a}
</pre>

Then create a script to control them

<pre>
cat dcos_control.sh
#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "You must specify a command. start, stop, poweroff"
  exit 1
fi

vms=$(cat dcos_vms.txt)

vmids=$(echo "$vms" | cut -d ' ' -f 2)

for vmid in $vmids
do
    case $1 in
    "start")
        VBoxManage  startvm $vmid --type headless
        ;;
    "stop")
        VBoxManage  controlvm $vmid savestate
        ;;
    "poweroff")
        VBoxManage  controlvm $vmid acpipowerbutton
        ;;
    *)
        echo "unrecognized command"
        ;;
    esac

done
</pre>

This script can be used to start, stop, poweroff the VM's listed in dcos_vms.txt
