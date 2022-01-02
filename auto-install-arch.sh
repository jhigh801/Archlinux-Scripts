#!/bin/sh

## installing pacman-contrib
pacman -S --noconfirm pacman-contrib
setfont ter-v22b
## Destroy data and partitions
wipefs -a  /dev/sda
## creating gpt table
sgdisk -Z  /dev/sda
## set 2048 alignment
sgdisk -a 2048 -o  /dev/sda
## creating partitions
sgdisk -n 1::+1M --typecode=1:ef02 --change-name=1:'BIOSBOOT'
sgdisk -n 2::+300M --typecode=1:ef00 --change-name=2:'EFIBOOT'
sgdisk -n 3::+265.5G --typecode=:8300 --change-name=3:'ROOT'
sgdisk -n 4::+190.0G --typecode=:8302 --change-name=4:'HOME'
sgdisk -n 5::+10.0G --typecode=:8200 --change-name=5:'SWAP'
## making filesystems
mkfs.vfat -F32  /dev/sda2
mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda4
mkswap /dev/sda5
swapon /dev/sda5
## mounting partitions
mount /dev/sda3  /mnt
mkdir -p /mnt/{efi,home}
mount /dev/sda2  /mnt/efi
mount /dev/sda4  /mnt/home
## time syncronisation
timedatectl set-ntp true
## pacman key install
pacman-key --init
pacman-key --populate archlinux
## sync pacman
pacman -Syy
## pacstrap
pacstrap /mnt base base-devel linux linux-firmware sudo nano networkmanager dhcpcd iwd bluez bluez-libs hddtemp thermald tlp sysfsutils usbutils e2fsprogs dosfstools inetutils netctl device-mapper cryptsetup less lvm2 dialog wpa_supplicant wireless_tools
## genfstab
genfstab -U /mnt  >>  /mnt/etc/genfstab
## arch-chroot
arch-chroot /mnt
## setting localtime
ln -sf /usr/share/zoneinfo/US/Eastern  /etc/localtime
## setting hardware clock
hwclock --systohc
## edit /etc/locale.gen
nano /etc/locale.gen
## Generate the locales
locale-gen
## Create the locale.conf(5) file, and set the LANG variable accordingly
echo "LANG=en_US.UTF-8"  >   /etc/locale.conf
## export locale to filesystem
export LANG=en_US.UTF-8
## Create hostname
echo "Arch-Plasma"  >  /etc/hostname
## setting up hosts
echo "127.0.0.1       localhost"  >>  /etc/hosts
echo "::1             localhost"  >>  /etc/hosts
echo "127.0.1.1       Arch-Plasma.localdomain   Arch-Plasma"  >>  /etc/hosts
## setting root password
passwd root
## Creating User
useradd -m -G  log,sys,network,floppy,scanner,power,rfkill,users,audio,video,storage,lp,wheel,adm  -s  /bin/bash  jon
## set passwd jon
passwd jon
## editing sudoers file
EDITOR=nano visudo
## installing grub,efibootmgr,efivar, & amd microcode
pacman -S --noconfirm grub efibootmgr efivar amd-ucode
grub-install --target=x86_64-efi  --efi-directory=/efi  --bootloader-id=GRUB --recheck  
grub-mkconfig -o  /boot/grub/grub.cfg
## enabling services
systemctl enable NetworkManager.service
systemctl enable dhcpcd@eno1.service
systemctl enable bluetooth.service
systemctl enable thermald.service
systemctl enable tlp.service
systemctl enable hddtemp.service
## downloading dev packages
pacman -S --noconfirm cmake extra-cmake-modules ninja doxygen meson uncrustify cppcheck check go rust
## downloading kde packages
pacman -Syyy && pacman -S --noconfirm kde-applications-meta kde-accessibility-meta kde-education-meta kde-games-meta kde-graphics-meta kde-multimedia-meta kdenetwork-filesharing kde-network-meta kde-pim-meta kde-sdk-meta kde-system-meta kde-utilities-meta plasma-meta plasma-desktop
## downloading xorg
pacman -S xorg xorg-server xorg-apps xorg-xinit picom xf86-video-qxl xf86-video-ati xf86-video-amdgpu xf86-video-vesa xf86-input-vmmouse xf86-input-libinput xorg-xkill xorg-twm 
## exiting chroot
exit
## umounting and rebooting
umount -R /mnt && reboot
## remove media from system before booting up
