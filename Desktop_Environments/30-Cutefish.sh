#!/bin/sh

## ------------------------ Cutefish Desktop {{{
sudo pacman -Syy ; sudo pacman -S --noconfirm --needed cutefish-calculator cutefish-core cutefish-dock cutefish-filemanager cutefish-icons cutefish-kwin-plugins cutefish-launcher cutefish-qt-plugins cutefish-screenlocker cutefish-settings cutefish-statusbar cutefish-terminal cutefish-wallpapers fishui libcutefish
## }}}
## ------------------------ SDDM {{{
sudo systemctl enable sddm.service
## }}}

echo "This Script is now Complete!"

