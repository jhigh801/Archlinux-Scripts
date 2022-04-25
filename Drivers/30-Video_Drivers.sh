#!/bin/sh

## ------------------------ Downloading & Installing xorg-video-drivers {{{
sudo pacman -Syy ; sudo pacman -S --noconfirm --needed xf86-video-ati xf86-video-amdgpu xf86-video-vesa xf86-video-qxl

echo "This script is complete!"
## }}}
