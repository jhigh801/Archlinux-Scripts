#!/bin/sh

## ------------------------ Gnome-Desktop {{{
sudo pacman -Syy ; sudo pacman -S gnome gnome-extra gnome-shell gnome-shell-extensions
## }}}
## ------------------------ Gdm enabled into Systemd {{{
sudo systemctl enable gdm.service
## }}}
