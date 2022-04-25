#!/bin/sh

## ---------------------------- Useradd {{{
useradd -m -g users -G sys,log,network,scanner,power,rfkill,video,storage,optical,lp,audio,wheel,adm  -s  /bin/bash  jon
## }}}

echo "This Script is now complete!"

