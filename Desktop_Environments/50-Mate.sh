#!/bin/sh

## ------------------------ Mate Desktop {{{
sudo pacman -Syy ; sudo pacman -S --noconfirm --needed mate-desktop atril pluma engrampa caja mozo eom caja-extensions-common caja-image-converter caja-open-terminal caja-sendto caja-share caja-wallpaper caja-xattr-tags python-caja marco mate-applet-dock mate-applets mate-applet-streamer mate-backgrounds mate-calc mate-common mate-control-center mate-icon-theme mate-icon-theme-faenza mate-media mate-menus mate-notification-daemon mate-panel mate-polkit mate-power-manager materia-gtk-theme mate-screensaver mate-sensors-applet mate-session-manager mate-settings-daemon mate-system-monitor mate-terminal mate-themes mate-user-guide mate-user-share mate-utils perl-class-accessor perl-www-mechanize python-authlib python-deprecation python-jellyfish python-sybil
## }}}
## ------------------------ Lightdm enabled {{{
sudo systemctl enable lightdm.service
## }}}

echo "This Script is Complete!"

