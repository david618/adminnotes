# Add Drive to CentOS

## Find the Drive

As root

<pre>
fdisk -l
</pre>

Output like
<pre>
Disk /dev/xvda: 32.2 GB, 32212254720 bytes, 62914560 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: dos
Disk identifier: 0x000abb0d

    Device Boot      Start         End      Blocks   Id  System
/dev/xvda1   *        2048    62914526    31456239+  83  Linux

Disk /dev/xvdb: 4505.4 GB, 4505420693504 bytes, 8799649792 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
</pre>

The drive /dev/xvdb has 4TB of space and no partitions.


## Create Partition with fdisk

<pre>
fdisk /dev/xvdb
</pre>

For example

<pre>
Command (m for help): n
Partition type:
   p   primary (0 primary, 0 extended, 4 free)
   e   extended
Select (default p): p
Partition number (1-4, default 1): 
First sector (2048-4294967295, default 2048): 
Using default value 2048
Last sector, +sectors or +size{K,M,G} (2048-4294967294, default 4294967294): 
Using default value 4294967294
Partition 1 of type Linux and of size 2 TiB is set
</pre>

**Note:** fdisk is limited to 2 TiB.

For larger drives use parted

<pre>
parted
</pre>

For example:

<pre>
(parted) print                                                            
Model: Xen Virtual Block Device (xvd)
Disk /dev/xvdb: 4505GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos
Disk Flags: 

Number  Start  End  Size  Type  File system  Flags

(parted) mklabel gpt
Warning: The existing disk label on /dev/xvdb will be destroyed and all data on this disk will be lost. Do you want to continue?
Yes/No? Yes
(parted) print                                                            
Model: Xen Virtual Block Device (xvd)
Disk /dev/xvdb: 4505GB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags: 

Number  Start  End  Size  File system  Name  Flags

(parted) mkpart primary 0GB 4505GB                                        
(parted) print                                                            
Model: Xen Virtual Block Device (xvd)
Disk /dev/xvdb: 4505GB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags: 

Number  Start   End     Size    File system  Name     Flags
 1      1049kB  4505GB  4505GB  xfs          primary

(parted) quit
</pre>

## Format the Partition

<pre>
mkfs -t xfs -n ftype=1 /dev/xvdb1 
</pre>

You should see something like:
<pre>
meta-data=/dev/xvdb1             isize=512    agcount=5, agsize=268435455 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0, sparse=0
data     =                       bsize=4096   blocks=1099955712, imaxpct=5
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=521728, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0

</pre>

## Mount the Partition

For Example

<pre>
mkdir /data
blkid=$(blkid | grep /dev/xvdb1)
uuid=$(echo $blkid | awk -F'"' '$0=$2')
fstabline="UUID=${uuid} /data    xfs   defaults   0  0"
echo $fstabline >> /etc/fstab
mount -a
[root@ip-172-31-7-231 ~]# df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/xvda1       30G  865M   30G   3% /
devtmpfs        476M     0  476M   0% /dev
tmpfs           496M     0  496M   0% /dev/shm
tmpfs           496M   13M  483M   3% /run
tmpfs           496M     0  496M   0% /sys/fs/cgroup
tmpfs           100M     0  100M   0% /run/user/1000
tmpfs           100M     0  100M   0% /run/user/0
/dev/xvdb1      4.1T   33M  4.1T   1% /data

</pre>

Notice the 4.1T drive is mounted to /data.


## For AWS

Create a Volume and attach to the EC2 instance.  


