#!/bin/sh

sudo rm -rf /etclocaltime &&
sudo ln -sf /usr/share/zoneinfo/America/Indiana/Indianapolis    >    /etc/localtime
heclock --systohc &&
echo "Script is done!" &&
echo "go to locale.sh"
