# --- Pre-Installation ---
setfont ter-128n &	# Setting Font and Size during install process.

# Setting Time-Date 
timedatectl set-ntp true &
timedatectl set-timezone US/Eastern &
timedatectl status &

# Formatting Partitions
mkfs.vfat -F32 /dev/sda1 &
mkfs.ext4 /dev/sda2 &
mkfs.ext4 /dev/sda3 &
mkswap /dev/sda4 &
swapon /dev/sda4 &

# Mounting Partitions
mount /dev/sda2  /mnt &
mkdir -p  /mnt/{boot/efi,home} &
mount /dev/sda1  /mnt/boot/efi &
mount /dev/sda3  /mnt/home &

# Setting Pacman keys
pacman-key --init &
pacman-key --populate &

# Reflector - Setting 15 fastest mirrors in America
reflector -c "United States"  -f 15  --sort rate --save /etc/pacman.d/mirrorlist &

# Pacstrap - Installing base packages and kernel 
pacstrap /mnt base base-devel linux-lts linux-headers linux-firmware intel-ucode grub efibootmgr efivar nano sudo vim vim-runtime&

# Genfstab
genfstab -U  /mnt  >>  /mnt/etc/fstab &

# --- Installation ---

# Chroot into /mnt
arch-chroot /mnt &

# Localtime
ln -sf /usr.share/zoneinfo/US/Eastern  /etc/localtime  &

# Updating System Clock
hwclock --systohc  &

# Updating Locale
nano /etc/locale.gen &
locale-gen &
export LANG=en_US.UTF-8  &
echo "LANG=en_US.UTF-8"  >>  /etc/locale.conf &

# Setting Hostname
echo "Archlinux-Awesome"   >>   /etc/hostname &

# Setting Hosts
echo "127.0.0.1    localhost"    >>   /etc/hosts &
echo "::1          localhost"    >>   /etc/hosts &
echo "127.0.1.1    Archlinux-Awesome.localdomain         Archlinux-Awesome"    >>   /etc/hosts &

# Setting Root Password
passwd &

# Setting User & Password
useradd -mG  wheel  jon  &
passwd jon  &

# Setting up Sudoers List
EDITOR=nano visudo  &

# Setting up Grub
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --recheck  /dev/sda &
grub-mkconfig -o  /boot/grub/grub.cfg  &

# Installing Packages
pacman -S networkmanager network-manager-applet nm-connection-editor xorg xorg-server xorg-drivers xorg-xkill awesome rlwrap dex vicious wireless_tools alsa-utils xclip cups ghostscript gutenprint cups-pdf cups-filters volumeicon pulseaudio pulseaudio-alsa pulseaudio-rtp pulseaudio-zeroconf pavucontrol bluez bluez-libs iwd iw wpa_supplicant tlp tlp-rdw thermald hddtemp smartmontools --noconfirm --needed &

# Enabling Services into Systemd
systemctl enable NetworkManager.service &
systemctl enable wpa_supplicant.service &
systemctl enable bluetooth.service &
systemctl enable tlp.service &
systemctl enable thermald.service &
systemctl enable iwd.service &
systemctl enable hddtemp.service &
systemctl enable cups.service &
systemctl enable systemd-timesyncd.service &

# Installing Git and GO for AUR
pacman -S git go go-tools --noconfirm --needed &

# Install xdg-user-dirs 
pacman -S xdg-user-dirs --noconfirm --needed &

# Install needed packages for Awesome
pacman -S thunar xfce4-power-manager picom dmenu ruby ruby-docs ruby-reline lxappearance alacritty xterm xorg-twm tk tcl libreoffice-still calibre ranger atools lzop cpio p7zip unace unzip zip unalz lzip xarchiver --noconfirm --needed &

# Exit out of chroot
exit &

# Unmount out of installer
umount -R  /mnt &

# Reboot into New Installation
reboot 
