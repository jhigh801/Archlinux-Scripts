#!/bin/sh

## ------------------------ Network Apps {{{
sudo pacman -Syy ; sudo pacman -S --noconfirm --needed networkmanager network-manager-applet nm-connection-editor wpa_supplicant iwd bluez bluez-libs bluez-utils bluez-tools dhcpcd firefox firefox-i18n-en-us ttf-fira-mono ttf-fira-sans ttf-roboto ttf-monoid ttf-monofur ttf-inconsolata firefox-adblock-plus geoip-database geoip-database-extra gd geoipupdate psutils
## }}}
## ------------------------ enabling Network Apps {{{
sudo systemctl enable NetworkManager.service
sudo systemctl enable iwd.service
## }}}

echo "This Script is now Complete!"
