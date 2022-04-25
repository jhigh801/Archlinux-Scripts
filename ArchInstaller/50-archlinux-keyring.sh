#!/bin/sh

## -------------------------- Archlinux-Keyring {{{
pacman-key --init
pacman-key --populate archlinux
## }}}

echo "This Script is now complate!"
 
