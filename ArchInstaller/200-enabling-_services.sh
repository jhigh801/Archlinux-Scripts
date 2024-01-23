#!/bin/sh 

systemctl enable NetworkManager.service
systemctl enable bluetooth.service
systemctl enable dhcpcd.service
systemctl enable wpa_supplicant.service
systemctl enable hddtemp.service
systemctl enable iwd.service
systemctl enable tlp.service
systemctl enable thermald.service
systemctl enable reflector.service
systemctl enable rsyncd.service
systemctl enable systemd-timesyncd.service
systemctl enable cups.service

echo "This Script is Complete!"
