#!/bin/sh

## ------------------------ Audio Drivers {{{
sudo pacman -Syy ; sudo pacman -S --noconfirm --needed gst-plugins-bad gst-plugins-bad-libs gst-plugins-base gst-plugins-base-libs gst-plugins-good gst-plugins-ugly gst-libav libdvdcss

echo "This Script is Complete!"

