# Resize Root Partition

We had a 50G root drive; however, the image from Azure used only 30G.

The root file system was created on partition /dev/sda2.

```
fdisk /dev/sda
```

- delete root partition (partition 2)
- recreate root partition (partition 2 using all space on the disk)
- reboot (systemctl reboot)

After reboot; expand the filesystem.

```
xfs_growfs /dev/sda2
```

