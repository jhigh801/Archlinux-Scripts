#!/bin/sh

sudo systemctl start NetworkManager.service
sudo systemctl start bluetooth.service
sudo systemctl start dhcpcd.service
sudo systemctl start wpa_supplicant.service
sudo systemctl start hddtemp.service
sudo systemctl start iwd.service
sudo systemctl start tlp.service
# sudo systemctl start reflector.service
sudo systemctl start rsyncd.service
sudo systemctl start avahi-daemon.service
sudo systemctl start fancontrol.service
sudo systemctl start systemd-resolved.service
sudo systemctl start systemd-timesyncd.service
sudo systemctl start cups.service
sudo systemctl start cups-browsed.service
echo "Script is Complete!"
