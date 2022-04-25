#!/bin/sh

## ------------------------ Xfce4-Desktop {{{
sudo pacman -Syy ;  sudo pacman -S --noconfirm --needed xfce4 xfce4-goodies xfconf xfwm4 xfwm4-themes thunar ffmpeg ffmpegthumbnailer catfish engrampa atril pluma mlocate gnome-disk-utility gparted gpart lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings accountsservice
## }}}
## ------------------------ lightdm {{{
sudo systemctl enable lightdm.service
## }}}



