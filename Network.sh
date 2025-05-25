#!/bin/env bash

pacman -S --needed --noconfirm networkmanager network-manager-applet nm-connection-editor bluez bluez-libs bluez-tools bluez-utils dhcpcd openresolv dnsutils dnsmasq dhclient iw iwd wireless_tools wireless-regdb wpa_supplicant tlp tk tcl gd ed geoip geoip-database geoip-database-extra reflector rsync geoipupdate geoclue hddtemp smartmontools &&

systemctl enable NetworkManager.service &&
systemctl enable bluetooth.service &&
systemctl enable wpa_supplicant.service &&
systemctl enable dhcpcd.service &&
systemctl enable tlp.service &&
systemctl enable reflector.service &&
systemctl enable rsyncd.service &&
systemctl enable hddtemp.service &&
systemctl enable avahi-daemon.service &&
systemctl enable fancontrol.service &&
systemctl enable systemd-resolved &&
systemctl enable systemd-timesyncd.service &&

echo "This Script is now complete!"
