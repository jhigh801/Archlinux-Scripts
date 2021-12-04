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
sgdisk -n 1:2048:616447 -t 1:ef00
sgdisk -n 2:616448:557410303 -t 2:8300
sgdisk -n 3:557410304:955869183 -t 3:8302
sgdisk -n 4:955869184:976773134 -t 4:8200
## making filesystems
mkfs.vfat -F32  /dev/sda1
mkfa.ext4 /dev/sda2
mkfs.ext4 /dev/sda3
mkswap /dev/sda4
swapon /dev/sda4
## mounting partitions
mount /dev/sda2  /mnt
mkdir -p /mnt/{boot,home}
mount /dev/sda1  /mnt/boot
mount /dev/sda3  /mnt/home
## time syncronisation
timedatectl set-ntp true
## pacman key install
pacman-key --init
pacman-key --populate archlinux
## sync pacman
pacman -Syy
## pacstrap
pacstrap /mnt base base-devel linux linux-firmware sudo nano
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
useradd -m -g users -G log,sys,network,floppy,scanner,power,rfkill,users,audio,video,lp,wheel,adm  -s  /bin/bash  jon
## set passwd jon
passwd jon
## editing sudoers file
EDITOR=nano visudo
## installing grub,efibootmgr,efivar, & amd microcde
pacman -S --noconfirm grub efibootmgr efivar amd-ucode
grub-install --efi-directory=/boot    /dev/sda
grub-mkconfig -o  /boot/grub/grub.cfg
## downloading dev packages
pacman -S --noconfirm cmake extra-cmake-modules ninja doxygen meson uncrustify cppcheck check go rust
## downloading kde packages
pacman -Syyy && pacman -S --noconfirm kde-applications-meta kde-accessibility-meta kde-education-meta kde-games-meta kde-graphics-meta kde-multimedia-meta kdenetwork-filesharing kde-network-meta kde-pim-meta kde-sdk-meta kde-system-meta kde-utilities-meta
## downloading xorg
pacman -S xorg xorg-server xorg-apps xorg-xinit picom xf86-video-qxl xf86-video-ati xf86-video-amdgpu xf86-video-vesa xf86-input-vmmouse xf86-input-libinput sddm sddm-kcm
## exiting chroot
exit
## umounting and rebooting
umount -a && reboot
## remove media from system before booting up
