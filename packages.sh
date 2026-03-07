#!/bin/bash

# Networking
sudo pacman -S --needed --noconfirm networkmanager network-manager-applet nm-connection-editor iw iwd bluez bluez-libs bluez-utils bluez-tools dhcpcd openresolv sysfsutils usbutils dosfstools f2fs-tools mtools mkinitcpio inetutils netctl device-mapper cryptsetup nano lvm2 dialog reflector rsync nilf-utils nfs-utils btrfs-progs bcachefs-tools jfsutils xfsprogs ntfs-3g udftools xorg-xhost polkit smartmontools tlp hddtemp ed tk tcl wpa_supplicant wireless-regdb wireless_tools 

# enabling services
systemctl enable NetworkManager.service
systemctl enable bluetooth.service
systemctl enable iwd.service
systemctl enable wpa_supplicant
systemctl enable dhcpcd.service
systemctl enable reflector.service
systemctl enable rsyncd.service
systemctl enable tlp.service
systemctl enable hddtemp.service

# Printing
sudo pacman --needed --noconfirm cups cups-pdf cups-filters gsfonts system-config-printer foomatic-db foomatic-db-engine gutenprint ghostscript python-pillow python-reportlab python-pip python-pipx python-setuptools simple-scan hplip cups-pk-helper python-pyqt5 cups-browsed

# enabling services
systemctl enable cups.service
systemctl enable cups-browsed.service

# Python
sudo pacman -S --needed --noconfirm python-setuptools python-pip python-pipx python-pysocks python-lxml python-lxml python-lxml-docs python-lxml-html-clean python-genshi python-cssselect python-beautifulsoup4 python-html5lib python-chardet python-cchardet python-soupsieve python-typing_extensions python-lockfile

# boot
sudo pacman -S --needed --noconfirm grub efibootmgr efivar os-prober intel-ucode amd-ucode

# Neovim
sudo pacman -S --needed --noconfirm libluv libutf8proc libuv libvterm lua51-lpeg luajit msgpack-c tree-sitter tree-sitter-c tree-sitter-lua tree-sitter-markdown tree-sitter-query tree-sitter-vim tree-sitter-vimdoc unibilium python-pynvim wl-clipboard xclip xsel java-environment java-rhino java-runtime nodejs npm ruby ruby-std-libs fd fzf 
