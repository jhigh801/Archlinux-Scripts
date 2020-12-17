#!/bin/sh


sudo passwd root &&
groupadd jon &&
useradd  -m  -g jon -G sys,log,network,floppy,scanner,power,rfkill,jon,video,storage,optical,lp,audio,wheel,adm  -s  /bin/bash  jon &&
passwd jon &&
EDITOR=nano visudo &&
echo "Script is Done!!"


