#!/bin/sh

sudo reflector  -c  'United States'    -a 15    -p  https   --sort rate   --save   /etc/pacman.d/mirrorlist &&
echo "Scripts done!!"

