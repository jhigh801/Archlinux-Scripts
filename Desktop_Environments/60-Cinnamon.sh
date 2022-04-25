#!/bin/sh

## ------------------------ Cinnamon Desktop {{{
sudo pacman -Syy ; sudo pacman -S --noconfirm --needed cinnamon cinnamon-control-center cinnamon-desktop cinnamon-menus cinnamon-screensaver cinnamon-session cinnamon-settings-daemon cinnamon-translations cjs nemo muffin
## }}}
## ------------------------ Lightdm enabled {{{
sudo systemctl enable lightdm.service
## }}}

echo "This Script is now Complete!"
