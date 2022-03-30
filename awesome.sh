#!/bin/sh

## =================================== Awesome Window Manager {{{
sudo pacman -S --noconfirm --needed awesome cairo dbus libxkbcommon-x11 gdk-pixbuf2 imlib2 libxdg-basedir libxkbcommon  lua53 lua53-lgi pango startup-notification xcb-util xcb-util-cursor xcb-util-keysyms xcb-util-wm xcb-util-xrm xorg-xmessage ttf-dejavu ttf-liberation ttf-bitstream-vera ttf-droid gnu-free-fonts noto-fonts ttf-croscore ttf-ibm-plex rlwrap dex vicious asciidoctor xmlto imagemagick ldoc cmake extra-cmake-modules doxygen docbook-xsl

## }}}
## =================================== Creating Directory {{{
mkdir ~/.config/awesome
## }}}
## =================================== Github-Sections {{{
git clone https://github.com/lcpz/awesome-freedesktop.git ~/.config/awesome/
git clone https://github.com/lcpz/lain.git ~/.config/awesome/
git clone --recurse-submodules --remote-submodules --depth 1 -j 2 https://github.com/lcpz/awesome-copycats.git
mv -bv awesome-copycats/{*,.[^.]*} ~/.config/awesome; rm -rf awesome-copycats
## }}}
echo "The Script is Complete!"
