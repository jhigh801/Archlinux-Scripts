#!/bin/sh

## ---------------------- Mounting-Partitions {{{
mount /dev/sda2   /mnt
mkdir -p /mnt/boot/efi
mkdir -p /mnt/home
mount /dev/sda1   /mnt/boot/efi
mount /dev/sda3   /mnt/home
## }}}

echo "This Script is now completed!" 
