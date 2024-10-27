#!/bin/sh 

systemctl enable NetworkManager.service
systemctl enable bluetooth.service
systemctl enable dhcpcd.service
systemctl enable wpa_supplicant.service
systemctl enable hddtemp.service
systemctl enable iwd.service
systemctl enable tlp.service
systemctl enable reflector.service
systemctl enable rsyncd.service
systemctl enable avahi-daemon.service
systemctl enable fancontrol.service
systemctl enable systemd-resolved.service
systemctl enable systemd-timesyncd.service
systemctl enable cups.service
systemctl enable cups-browsed.service
echo "This Script is Complete!"
