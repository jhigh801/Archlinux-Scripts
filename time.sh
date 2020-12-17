#!/bin/sh

sudo timedatectl set-ntp true &&
sudo timedatectl set-timezone America/Indiana/Indianapolis &&
sudo timedatectl status &&
echo "Script done!!"

