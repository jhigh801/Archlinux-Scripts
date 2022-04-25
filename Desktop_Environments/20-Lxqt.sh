#!/bin/sh

## ------------------------ LXqt Desktop {{{
sudo pacman -Syy ; sudo pacman -S --noconfirm --needed liblxqt lximage-qt lxqt-about lxqt-admin lxqt-archiver lxqt-build-tools lxqt-config lxqt-globalkeys lxqt-notificationd lxqt-openssh-askpass lxqt-panel lxqt-policykit lxqt-powermanagement lxqt-qtplugin lxqt-runner lxqt-session lxqt-sudo lxqt-themes pcmanfm-qt xdg-desktop-portal-lxqt
## }}}
## ------------------------ SDDM {{{
sudo systemctl enable sddm.service
## }}}

