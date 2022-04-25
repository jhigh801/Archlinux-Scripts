#!/bin/sh

## -------------------------- Genfstab {{{
genfstab -U /mnt  >>  /mnt/etc/fstab
## }}}

echo "This Script is now completed!"


