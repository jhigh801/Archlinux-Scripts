#!/bin/sh

## --------------- Syncing Pacman before downloading packages.
sudo pacman -Syyy

## --------------- Downloading Packages for Plasma-Desktop.
sudo pacman -S --noconfirm --needed plasma-wayland-session kde-applications-meta kde-accessibility-meta kde-education-meta kde-games-meta kde-graphics-meta kde-multimedia-meta kde-network-meta kde-pip-meta kde-sdk-meta kde-system-meta kde-utility-meta plasma-meta


## --------------- Enabling SDDM as Display Manager.
sudo systemctl enable sddm.service

## Rebooting system
sudo reboot
