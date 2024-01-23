#!/bin/sh

## -------------------------- Pacstrap {{{
pacstrap  /mnt  base base-devel linux-lts linux-lts-headers linux-firmware sudo nano networkmanager network-manager-applet nm-connection-editor iwd iw wpa_supplicant bluez bluez-libs cups cups-pk-helper ghostscript gutenprint git e2fsprogs reiserfsprogs xfsprogs ntfs-3g dosfstools jfsutils sysfsutils exfatprogs exfat-utils btrfs-progs cifs-utils samba smbclient gvfs gvfs-afc gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb python python-pip python-setuptools reflector rsync python-lockfile python-pysocks python-brotli python-lxml python-lxml-docs python-genshi python-beautifulsoup4 python-cssselect efibootmgr efivar grub intel-ucode smartmontools
## }}}

echo "This Script is now completed!"

