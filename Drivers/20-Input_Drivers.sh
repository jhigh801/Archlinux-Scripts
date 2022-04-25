#!/bin/sh

## ------------------------ Download & Install of Input Drivers {{{
sudo pacman -Syy ; sudo pacman -S --noconfirm --needed xf86-input-libinput xf86-input-synaptics xf86-input-vmmouse

echo "This Script is Complete!"
## }}}

