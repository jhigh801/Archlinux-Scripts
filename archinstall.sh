#!/bin/sh

## ========================= Format Partitions {{{
mkfs.fat -F32  /dev/sda1
mkfs.ext4 /dev/sda2
mkfs.ext4 /dev/sda3
mkswap /dev/sda4
swapon /dev/sda4
## }}}
## ========================= Mount Partitions {{{
mount /dev/sda2  /mnt
mkdir /mnt/{efi,home}
mount /dev/sda1  /mnt/efi
mount /dev/sda3  /mnt/home
## }}}
## ========================= TimeDateCtl {{{
timedatectl set-ntp true
timedatectl set-timezone US/Eastern 
timedatectl status
## }}}
## ========================= Setting up Pacman Keyring {{{
pacman-key --init
pacman-key --populate archlinux
## }}}
## ========================= Reflector {{{
reflector --latest 10  --protocol https   --save /etc/pacman.d/mirrorlist
## }}}
## ========================= Pacstrap {{{
pacstrap /mnt base base-devel linux-lts linux-lts-headers iwd networkmanager network-manager-applet perl-timedate nm-connection-editor gd geoip-database psutils gvfs gvfs-afc gvfs-goa gvfs-google gvfs-gphoto2 gvfs-nfs gvfs-mtp gvfs-smb smbclient samba cifs-utils nfs-utils nilfs-utils reiserfsprogs reflector rsync python python-pip python-setuptools python-lockfile python-pysocks python-brotli python-genshi python-lxml python-lxml-docs python-beautifulsoup4 python-cssselect elfutils dosfstools e2fsprogs nano sudo vim vim-runtime git tlp thermald hddtemp smartmontools ghostscript gutenprint foomatic-db foomatic-db-engine
## }}}
## ========================= Genfstab {{{
genfstab -U  /mnt  >>  /mnt/etc/fstab
## }}}
## ========================= Switch to Arch-chroot {{{
arch-chroot /mnt
## }}}
## ========================= Setting Localtime {{{
rm -rf /etc/localtime
ln -sf /usr/share/zoneinfo/US/Eastern  /etc/localtime
## }}}
## ========================= Setting Hardware Clock {{{
hwclock --systohc
## }}}
## ========================= Setting the Locale {{{
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8"  >>  /etc/locale.conf
export LANG=en_US.UTF-8
echo "Arch-Openbox"  >>  /etc/hostname
echo "127.0.0.1			localhost"   >>  /etc/hosts
echo "::1			localhost"   >>  /etc/hosts
echo "127.0.1.1			Arch-Openbox.localdomain Arch-Openbox"  >>  /etc/hosts
## }}}
## ========================= Setting root passwd {{{
passwd root:password | chpasswd
## }}}
## ========================= Adding Group {{{
groupadd jdhighley
## }}}
## ========================= Adding User {{{
useradd -m -g jdhighley -G sys,log,network,scanner,power,rfkill,video,storage,optical,lp,jdhighley,wheel,adm  -s  /bin/bash jon
## }}}
## ========================= Setting Password for User {{{
passwd jon:password | chpasswd
## }}}
## ========================= Adding User to Sudoers List {{{
EDITOR=vim visudo
## }}}
## ========================= Installing Grub Bootloader {{{
sudo pacman -S --noconfirm --needed grub efibootmgr efivar amd-ucode
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB --recheck  /dev/sda
grub-mkconfig -o  /boot/grub/grub.cfg
## }}}
## ========================= Installing Drivers {{{
pacman -S --noconfirm --needed xf86-video-amdgpu xf86-video-ati xf86-video-fbdev xf86-video-vesa xf86-video-qxl
pacman -S --noconfirm --needed xf86-input-vmmouse xf86-input-synaptic xf86-input-libinput 
pacman -S --noconfirm --needed xorg xorg-apps mesa xorg-twm xterm rxvt-unicode 
## }}}
## ========================= Enabling Services {{{
systemctl enable NetworkManager.service
systemctl enable iwd.service
systemctl enable samba.service
systemctl enable cups.service 
systemctl enable tlp.service
systemctl enable thermald.service
systemctl enable hddtemp.service
## }}}
## ========================= Exit Chroot {{{
exit
## }}}
## ========================= Unmount and Restart {{{
umount -R  /mnt
echo "this script is complete!"
reboot
## }}}

