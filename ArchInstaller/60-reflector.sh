#!/bin/sh

## -------------------------- Reflector {{{
reflector -c "United States"  -l 10  -p http,https  --sort rate  --save  /etc/pacman.d/mirrorlist
## }}}

echo "This Script is now complete!"


 
