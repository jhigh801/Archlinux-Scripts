#!/bin/sh

## --------------------------------- Cleaning-Disk {{{
setfont ter-v22b
sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
wipefs -a  /dev/sda
sgdisk -Z  /dev/sda
## }}}

echo "This Script is now complete!" 
