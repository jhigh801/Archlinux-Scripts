#!/bin/sh

## ----------------------- Timedatectl {{{
timedatectl set-ntp true
timedatectl set-timezone US/Eastern
timedatectl status
## }}}

echo "This Script is now completed!"
  
