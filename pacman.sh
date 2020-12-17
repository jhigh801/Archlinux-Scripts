#!/bin/sh

sudo pacman-key --init &&
sudo pacman-key --populate archlinux &&
sudo pacman -Syyy &&
sudo pacman -S reflector mlocate  &&
echo "Script is Done !!" &&
echo "Go to Script "Reflector.sh"
