#!/bin/sh

## ------------------------ Plasma Desktop {{{
sudo pacman -Syy ; sudo pacman -S plasma-meta kde-accessibility-meta kde-applications-meta kde-education-meta kde-games-meta kde-graphics-meta kde-multimedia-meta kde-network-meta kde-pim-meta kde-sdk-meta kde-system-meta kde-utilities-meta kdeplasma-addons kvantum
## }}}
## ------------------------ SDDM Enabled {{{
sudo systemctl enable sddm.service
## }}}
