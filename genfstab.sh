#!/bin/sh

sudo genfstab  -U  /mnt  >>  /mnt/etc/fstab  &&
echo "Script done !!"

