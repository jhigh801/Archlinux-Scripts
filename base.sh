#!/bin/sh

# Reflector										
sudo reflector -c  "United States"  -a 15  -p https  --sort rate   --save  /etc/pacman.d/mirrorlist &

# Pacstrap
sudo pacstrap /mnt  base base-devel linux linux-firmware vim git sysfsutils usbutils e2fsprogs dosfstools inetutils netctl dhcpcd device-mapper cryptsetup nano less lvm2 dialog wpa_supplicant wireless_tools iwd networkmanager python2 python2-pip python-setuptools bluez bluez-utils &

# Genfstab
genstab -U  /mnt  >>  /mnt/etc/fstab &

# Arch-Chroot
arch-chroot  /mnt  &

# Configure Time Zone
rm -rf  /etc/localtime &
ln -sf  /usr/share/zoneinfo/America/Indiana/Indianapolis  >   /etc/localtime &
hwclock --systohc &

# Configuring Locale
nano /etc/locale.gen &
locale-gen &
echo LANG=en_US.UTF-8  >  /etc/locale.conf &
export LANG=en_US.UTF-8 &

# Configure Hostname
echo Mission-Control  >  /etc/hostname &

# Configure Hosts File
echo 127.0.0.1			localhost   >  /etc/hosts &
echo ::1			localhost   >  /etc/hosts &
echo 127.0.1.1			Mission-Control.localdomain Mission-Control   >  /etc/hosts &

# Setting Root Password
passwd root &

# Configuring Group
groupadd jdhighley &

# Configuring Users 
useradd -m -g jdhighley -G sys,log,network,floppy,scanner,power,rfkill,jdhighley,video,storage,optical,audio,lp,wheel,adm  -s  /bin/bash  jon &

# Setting User Password
passwd jon &

# Setting up sudoers file
EDITORS=vim visudo &

# Configuring Grub
pacman -S grub efibootmgr efivar amd-ucode &
grub-install  --efi-directory=/boot   /dev/sda  &
grub-mkconfig  -o  /boot/grub/grub.cfg &
 
# Installing Drivers
pacman -S --needed xf86-video-amdgpu xf86-video-ati xf86-input-libinput xf86-video-qxl xf86-input-vmmouse xorg-drivers &

# Installing Xorg
pacman -S xorg xorg-server xorg-apps xorg-xkill xorg-xinit xterm mesa &

# Installing all Display Managers
pacman -S gdm lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings sddm lxdm  &

# Enabling Features Needed 
sudo systemctl enable bluetooth.service &
sudo systemctl enable NetworkManager.service &
sudo systemctl enable sshd.service &

# Syncronizing Time
timedatectl set-ntp true &
timedatectl set-timezone America/Indiana/Indianapolis &
timedatectl status &

# Exiting Chroot
exit &

# Unmounting Partitions
umount -a &
reboot &

echo "This Script is Finished!"

