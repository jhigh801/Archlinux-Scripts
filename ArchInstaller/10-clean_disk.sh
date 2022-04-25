#!/bin/sh

## --------------------------------- Cleaning-Disk {{{
setfont ter-v22b
wipefs -a  /dev/sda
sgdisk -Z  /dev/sda
## }}}

echo "This Script is now complete!" 
