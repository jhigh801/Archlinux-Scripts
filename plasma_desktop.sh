#!/bin/env

# -------------- Setting Font {{{
setfont ter-124n 

# -------------- Formatting Partitions {{{
mkfs.vfat -F32  /dev/sda1 
mkfs.ext4 /dev/sda2
mkfs.ext4 /dev/sda3 
mkswap /dev/sda4
swapon /dev/sda4

# -------------- Mounting Partitions {{{
mount /dev/sda2  /mnt
mkdir -p  /mnt/{boot/efi,home}
mount /dev/sda1  /mnt/boot/efi
mount /dev/sda3  /mnt/home

# -------------- Timedatectl {{{
timedatectl set-ntp true
timedatectl set-timezone US/Eastern
timedatectl status

# -------------- Pacman Keyring {{{
pacman-key --init
padman-key --populate

# -------------- Reflector {{{
reflector -c "United States" -a 1 -f40 -p http,https --sort rate --save /etc/pacman.d/mirrorlist

# -------------- Pacstrap {{{
pacstrap /mnt base base-devel linux linux-headers linux-firmware sudo nano vim vim-runtime ruby ruby-docs rubygems git perl-libwww tk tcl perl-term-readkey perl-io-socket-ssl perl-authen-sasl perl-mediawiki-api perl-datetime-format-iso8601 perl-lwp-protocol-https perl-cgi python subversion org.freedesktop.secrets libsecret gettext luarocks efibootmgr efivar grub intel-ucode networkmanager network-manager-applet nm-connection-editor bluez bluez-libs wpa_supplicant iwd 

# -------------- Genfstab {{{
genfstab -U /mnt >> /mnt/etc/fstab

# -------------- Chroot {{{
arch-chroot /mnt

# -------------- Localtime {{{
ln -sf /usr/share/zoneinfo/US/Eastern  /etc/localtime

# -------------- Hardware Clock {{{
hwclock --systohc

# -------------- Locales {{{
nano /etc/locale.gen
locale-gen
export LANG=en_US.UTF-8
echo "LANG=en_US.UTF-8"  >>  /etc/locale.conf

# -------------- Hostname {{{
echo "Arch-Plasma"  >>  /etc/hostname

# -------------- Hosts {{{
echo "127.0.0.1		localhost"  >>  /etc/hosts
echo "::1					localhost"  >>  /etc/hosts
echo "127.0.1.1   Arch-Plasma.localdomain    Arch-Plasma"  >>  /etc/hosts

# -------------- Root Password {{{
passwd

# -------------- User add {{{
useradd -mG wheel  jon

# -------------- User Password {{{
passwd jon

# -------------- Sudoer's List {{{
EDITOR=nano visudo

# -------------- Grub {{{
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --recheck  /dev/sda
grub-mkconfig -o  /boot/grub/grub.cfg

# -------------- Installing Drivers {{{
pacman -S xorg xorg-server xorg-drivers xorg-xkill --noconfirm --needed


# -------------- Download Desktop meta packages {{{
pacman -S kde-accessibility-meta kde-applications-meta kde-education-meta kde-games-meta kde-graphics-meta kde-multimedia-meta kde-network-meta kde-pim-meta kde-sdk-meta kde-system-meta kde-utilities-meta --noconfirm --needed

# -------------- Download Qt5 & Qt6 Packages for added Features {{{
pacman -S qt5 qt6 --noconfirm --needed

# -------------- Sddm - Display Manager for Plasma {{{
pacman -S sddm sddm-kcm --noconfirm --needed 

# -------------- Enabling Services {{{
systemctl enable NetworkManager.service
systemctl enable wpa_supplicant.service
systemctl enable bluetooth.service
systemctl enable iwd.service
systemctl enable sddm.service
systemctl enable systemd-timesyncd.service

# -------------- Installing XDG-USER-DIRS Package {{{
pacman -S xdg-user-dirs --noconfirm --needed

# -------------- Exit Chroot {{{
exit

# -------------- Unmount System & Reboot {{{
umount -R  /mnt 
reboot
