#!/bin/sh

## ------------------------ Formatting-Partitions {{{
mkfs.vfat -F32  /dev/sda1
mkfs.ext4 /dev/sda2
mkfs.ext4 /dev/sda3
mkswap /dev/sda4
swapon /dev/sda4
## }}}

echo "This Script is now complete!"
 
