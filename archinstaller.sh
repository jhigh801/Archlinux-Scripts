#!/bin/sh

################################################################
################## Set Font to Terminus
################################################################
setfont term-v22b

################################################################
################## Cleaning HDD
################################################################
wipefs -a  /dev/sda
sgdisk -Z  /dev/sda

################################################################
################## Creating Partitions
################################################################
sgdisk -n  1:2048:616447  --typecode=1:ef00  -c  1:'EFIBOOT'
sgdisk -n  2:616448:557410303   --typecode=2:8300  -c  2:'ROOT'
sgdisk -n  3:557410304:955869183 --typecode=3:8302  -c  3:'HOME'
sgdisk -n  4:955869184:976773134  --typecode=4:8200  -c  4:'SWAP'

################################################################
################## Fornatting Partitions
################################################################
mkfs.vfat -F32  /dev/sda1
mkfs.ext4  /dev/sda2
mkfs.ext4  /dev/sda3
mkswap /dev/sda4
swapon /dev/sda4

################################################################
################## Mounting Partitions
################################################################
mount /dev/sda2  /mnt
mkdir -p  /mnt/{efi,home}
mount /dev/sda1  /mnt/efi
mount /dev/sda3  /mnt/home

################################################################
################## Timedatectl
################################################################
Timedatectl set-ntp true

################################################################
################## Installing Archlinux-Keyring
################################################################
pacman-key --init
pacman-key --populate Archlinux

################################################################
################## Reflector
################################################################
reflector -a 48 -c "United States" -f 5 -l 20 --sort rate --save /etc/pacman.d/mirrorlist

################################################################
################## Pacstrap
################################################################
pacstrap /mnt base base-devel linux-lts linux-lts-headers linux linux-headers linux-firmware nano networkmanager network-manager-applet nm-connection-editor cups cups-filters cups-pdf cups-pk-helper libcups tlp thermald hddtemp acpid acpi acpilight reflector python python-pip python-setuptools python-pysocks python-lockfile python-brotli python-lxml python-genshi python-lxml-docs python-beautifulsoup4 python-cssselect python-pycups rsync system-config-printer iwd openssh firewalld --nonconfirm --needed

################################################################
################## Genfstab
################################################################
genfstab -U  /mnt  >>  /mnt/etc/genfstab

################################################################
################## Arch-chroot
################################################################
arch-chroot /mnt

################################################################
################## LocalTime
################################################################
ln -sf /usr/share/zoneinfo/US/Eastern  /etc/LocalTime
hwclock --systohc

################################################################
################## Locales
################################################################
sed -i '178s/.//' /etc/locale.gen
locale-gen

echo "LANG=en_US.UTF-8"   >>   /etc/locale.conf
export LANG=en_US.UTF-8

################################################################
################## Hostname
################################################################
echo "Arch"  >>  /etc/hostname

################################################################
################## Hosts
################################################################
echo "127.0.0.1         localhost"   >>  /etc/hosts
echo "::1               localhost"   >>  /etc/hosts
echo "127.0.1.1         Arch.localdomain Arch"   >>   /etc/hosts

################################################################
################## Root Password
################################################################
passwd root | chpasswd

################################################################
################## Useradd
################################################################
useradd -m -g users -G sys,log,network,scanner,power,rfkill,users,video,storage,optical,lp,audio,wheel,adm  -s  /bin/bash  jon

################################################################
################## User Password
################################################################
passwd jon | chpasswd

################################################################
################## Sudoers
################################################################
EDITOR=nano visudo

################################################################
################## Grub
################################################################
pacman -S --needed grub efibootmgr efivar amd-ucode
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB  --recheck  /dev/sda
grub-mkconfig -o  /boot/grub/grub.cfg

################################################################
################## Mkinitcpio
################################################################
mkinitcpio -p linux-lts

################################################################
################## Drivers
################################################################
pacman -S --noconfirm --needed  xf86-video-ati xf86-video-amdgpu xf86-video-vesa xf86-video-qxl xf86-input-vmmouse xf86-input-synaptics xf86-input-libinput

################################################################
################## Xorg
################################################################
pacman -S --noconfirm --needed xorg xorg-server xorg-apps xorg-xkill xorg-twm xterm xorg-docs xorg-fonts-100dpi xorg-fonts-75dpi xorg-fonts-alias-100dpi xorg-fonts-alias-75dpi xorg-fonts-alias-misc xorg-fonts-misc xorg-server-xephyr xorg-xmag xorg-xprop xorg-xmessage

################################################################
################## Display Manager
################################################################
pacman -S --noconfirm --needed lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings accountsservice lightdm-slick-greeter
# pacman -S --noconfirm --needed sddm sddm-kcm

################################################################
################## Desktop Environments
################################################################
####### (XFCE4)
pacman -S --noconfirm --needed xfce4 xfce4-goodies catfish xfwm4 xfwm4-themes thunar engrampa

################################################################
################## Window Managers
################################################################
####### (Openbox)
pacman -S --noconfirm --needed openbox obconf lxappearance lxappearance-obconf tint2 volumeicon numlockx nitrogen dmenu ttf-roboto ttf-monofur ttf-monoid ttf-inconsolata ttf-ubuntu-font-family ttf-dejavu ttf-fira-code ttf-fira-sans ttf-fira-mono

####### (i3)
pacman -S --noconfirm --needed i3-gaps i3lock i3blocks i3status rofi perl-anyevent-i3 perl perl-anyevent perl-json-xs

####### (Awesome)
pacman -S --noconfirm --needed awesome python-jedi vicious startup-notification rlwrap dex asciidoctor ttf-croscore ttf-droid noto-fonts ttf-liberation ttf-bitstream-vera ttf-ibm-plex gnu-free-fonts

################################################################
################## Enabling System Services
################################################################
systemctl enable NetworkManager.service
systemctl enable wpa_supplicant.service
systemctl enable iwd.service
systemctl enable tlp.service
systemctl enable hddtemp.service
systemctl enable thermald.service
systemctl enable lightdm.service
systemctl enable sshd.service
systemctl enable openssh.service
systemctl enable firewalld.service
systemctl enable cups.service
systemctl enable acpid.service

################################################################
################## Games
################################################################
pacman -S --noconfirm --needed kde-games aisleriot gnome-mahjongg

################################################################
################## Graphics
################################################################
pacman -S --noconfirm --needed inkscape blender gimp gimp-help-en gpick peek viewnior

################################################################
################## Internet
################################################################
pacman -S --noconfirm --needed firefox thunderbird filzilla chromium vivaldi vivaldi-ffmpeg-codecs

################################################################
################## Multimedia
################################################################
pacman -S --noconfirm --needed audacious audacious-plugins celluloid clementine vlc mpv pulseaudio pulseaudio-alsa pavucontrol pamixer pulseaudio-equalizer pulseaudio-jack pulseaudio-rtp pulseaudio-zeroconf paprefs gst-plugins-bad gst-plugins-bad-libs gst-plugins-base gst-plugins-base-libs gst-plugins-good gst-plugins-ugly gstreamer-vaapi gst-libav libdvdcss exfatprogs exfat-utils

################################################################
################## File Systems
################################################################
pacman -S --noconfirm --needed cifs-utils e2fsprogs dosfstools erofs-utils f2fs-tools fuse2fs fuse-overlayfs gvfs gvfs-afc gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-smb jfsutils gvfs-nfs gvfs-smb lfs mtpfs reiserfsprogs sshfs sysfsutils

################################################################
################## Compression tools
################################################################
pacman -S --noconfirm --needed atool bzip2 gzip zip laszip laszip2 lbzip2 libzip lrzip lzip p7zip pbzip2 perl-archive-zip perl-compress-bzip2 lhasa unrar unzip cpio

################################################################
################## Slick-greeter
################################################################
nano /etc/lightdm/lightdm.conf

################################################################
################## Finishing Up
################################################################
exit
umount -R /mnt
reboot
fi
