#!/bin/sh
#
# Setting the Font per Terminal.
setfont ter-128n
echo "The Font is Set!"

# Formatting the Partitions.
mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2 
mkfs.btrfs /dev/sda3
echo "Formating Phase is complete!"

# Mounting Partitions.
mount /dev/sda3 /mnt
echo "The Mount Partition is Mounted!"

# Creating Btrfs Subvolumes.
btrfs su cr /mnt/@
btrfs su cr /mnt/@home
btrfs su cr /mnt/@snapshots
btrfs su cr /mnt/@var_log
echo "Btrfs Subvolumes Created."

# Unmounting /mnt.
umount /mnt 
echo "/mnt Unmounted."
# Mounting the Subvolumes.
mount -o noatime,compress=lzo,space_cache=v2,subvol=@ /dev/sda3 /mnt

# Creating the Directories.
mkdir -p /mnt/{boot,home,.Snapshots,var_log}
echo "Directories Created."

# Continuing mounting the Subvolumes.
mount -o noatime,compress=lzo,space_cache=v2,subvol=@home /dev/sda3 /mnt/home
mount -o noatime,compress=lzo,space_cache=v2,subvol=@snapshots /dev/sda3 /mnt/.Snapshots
mount -o noatime,compress=lzo,space_cache=v2,subvol=@var_log /dev/sda3 /mnt/var_log
echo "mounting of Subvolume is Complete."

# Mounting of Boot Partition.
mount /dev/sda1 /mnt/boot
echo "boot Partition Mounted!"

# Setting TimeDatectl
timedatectl set-ntp true
echo "TimeDatectl Set."

# Installing and Enabling Archlinux Keyring.
pacman-key --init
pacman-key --populate
echo "Keyring Installed and Enabled."

# Setting Mirrors with Reflector.
reflector -c US -l 15 -p https --sort rate --save /etc/pacman.d/mirrorlist
echo "Reflector is Complete!"

# Pacstrap
pacstrap /mnt base base-devel linux linux-headers linux-firmware go grub efibootmgr efivar intel-ucode amd-ucode nano sudo networkmanager network-manager-applet nm-connection-editor thermald acpi acpid smartmontools hddtemp neovim dhcpcd iwd iw wpa_supplicant bluez bluez-libs dialog hplip xdg-utils xdg-user-dirs alsa-utils alsa-firmware inetutil snapper dosfstools mtools git reflector rsync python cups cups-filters cups-browsed cups-pk-helper ghostscript gutenprint python-pillow cmake extra-cmake-modules ninja tk tcl 
echo "Pacstrap is Complete!"

# Genfstab
genfstab -U /mnt >> /mnt/etc/fstab
echo "genfstab is Installed."

# Arch-Chroot
arch-chroot /mnt
echo "Switched to Chroot!"

# Setting Localtime.
ln -sf /usr/share/zoneinfo/America/Fort_Wayne   /etc/localtime
echo "Localtime is set"

# Setting Hardware Clock.
hwclock --systohc
echo "Hardware Clock is Set!"

# Setting Locale.
nano /etc/locale.gen
locale-gen
export LANG=en_US.UTF-8
echo "LANG=en_US.UTF-8"   >>  /etc/locale.conf
echo "Locale is set."

# Setting Hostname.
echo "Archlinux"  >>  /etc/hostname
echo "Hostname is Set!"

# Setting Hosts.
echo "127.0.0.1		localhost"    >> /etc/hosts
echo "::1	localhost"  >> /etc/hosts
echo "127.0.1.1		Archlinux.localdomain	Archlinux"
echo "hosts file is set"

# Setting Root Password.
passwd root
echo "Root Password is Set!"

# Creating User Account.
useradd -mG wheel jon
echo "User Account Created!"

# Setting User Password.
passwd jon
echo "User Account Password Set!"

# Setting Sudoers File.
EDITOR=nvim visudo
echo "Sudoers File is Set!"

# Editing Mkinitcpio.conf
nvim /etc/mkinitcpio.conf
echo "mkinitcpio.conf is Modified!"

# Creating and Installing of Grub.
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB --recheck /dev/sda 
grub-mkconfig -o  /boot/grub/grub.cfg
echo "Grub is installed!"

# Enabling Systemctl Services
systemctl enable NetworkManager.service
systemctl enable wpa_supplicant.service
systemctl enable bluetooth.service
systemctl enable dhcpcd.service
systemctl enable acpid.service
systemctl enable hddtemp.service
systemctl enable thermald.service
systemctl enable cups.service
systemctl enable cups-browsed.service
systemctl enable systemd-timesyncd.service



