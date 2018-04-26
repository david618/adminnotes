# tune2fs

Had a second 1TB drive on Mint 18 (Linux).

Default filesystem ext4 reserves 5% of the disk about 50G.  Not needed on secondary drive.

`sudo tune2fs -m 0 /dev/sdb1`

Disk increased from 860GB to 910GB. 

