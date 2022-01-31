#!/bin/sh

## root password
passwd root ;
useradd -m -G sys,log,network,scanner,rfkill,users,video,storage,optical,lp,audio,wheel,adm  -s  /bin/sh   jon ;
passwd jon ;
EDITOR=nano visudo ;




echo "This Script is Completed!"