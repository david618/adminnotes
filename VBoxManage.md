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

<pre>
#!/bin/bash

VMGRP="CentOS7_105"
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
