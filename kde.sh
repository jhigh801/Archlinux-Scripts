#!/bin/sh

sudo pacman -S kde-accessibility-meta kde-applications-meta kde-education-meta kde-games-meta kde-graphics-meta	kde-multimedia-meta kde-network-meta kde-pim-meta kde-sdk-meta kde-system-meta kde-utilities-meta plasma-meta &&

	sudo systemctl enable bluetooth.service &&
	sudo systemctl enable sshd.service &&
	sudo systemctl enable sddm.service &&
	sudo systemctl enable NetworkManager.service &&
	sudo systemctl enable dhcpcd@eno1.service &&

echo "This Script is finished!"



