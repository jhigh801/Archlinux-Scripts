#!/usr/bin/env zsh

# Setting Font
setfont ter-122b

# formatting Partitions
mkfs.fat -F32 /dev/sda1
echo "Partition Formatted."

mkswap /dev/sda2
swapon /dev/sda2
echo "Swap is Formatted and Activated."

mkfs.btrfs -f /dev/sda3
echo "btrfs is successfully formatted."

# Mounting
mount /dev/sda3 /mnt
echo "btrfs Partition is now mounted."

# Creating btrfs subvolumes
btrfs su cr /mnt/@
echo "subvolume ./mnt/@ created."

btrfs su cr /mnt/@home
echo "subvolume ./mnt/@home created."

btrfs su cr /mnt/@log
echo "subvolume ./mnt/@log created."

btrfs su cr /mnt/@pkg
echo "subvolume ./mnt/@pkg created."

btrfs su cr /mnt/@tmp
echo "subvolume ./mnt/@tmp created."

btrfs su cr /mnt/@opt
echo "subvolume ./mnt/@opt created."

umount -a
echo "umount complete!"

mount -o noatime,compress=lzo,space_cache=v2,subvol=@ /dev/sda3 /mnt
echo "mounting /mnt complete!"
mkdir -p /mnt/{boot,home,var/log,var/cache/pacman/pkg,tmp,opt}
echo "Directories Created."
mount -o noatime.compress=lzo,space_cache=v2,subvol=@home /dev/sda3 /mnt/home
echo "mounting /mnt/home complete!"
mount -o noatime,compress=lzo,space_cache=v2,subvol=@log /dev/sda3 /mnt/var/log
echo "mounting /var/log complete!"
mount -o noatime,compress=lzo,space_cache=v2,subvol=@pkg /dev/sda3 /mnt/var/cache/pacman/pkg
echo "mounting /var/cache/pacman/pkg complete!"
mount -o noatime,compress=lzo,space_cache=v2,subvol=@tmp /dev/sda3 /mnt/tmp
echo "mounting /mnt/tmp complete!"
mount -o noatime,compress=lzo,space_cache=v2,subvol=@opt /dev/sda3 /mnt/opt
echo "mounting /mnt/opt complete!"
mount /dev/sda1 /mnt/boot
echo "mounting /mnt/boot complete!"

# timedatectl setup
timedatectl set-ntp true
timedatectl
pacman-key --init
pacman-key --populate archlinux
echo "Timedatectl setup complete!"

# reflector
reflector -c US -l 50 -p https,http --verbose --sort rate --save /etc/pacman.d/mirrorlist --download-timeout 90
echo "reflector complete!"

# pacman mirror synchronization.
pacman -Syy
echo "mirror sync complete!"

# pacstrap
pacstrap -K /mnt base base-devel linux linux-headers linux-lts linux-lts-headers linux-firmware vim vim-runtime sudo btrfs-progs nano intel-ucode amd-ucode git go 
echo "Pacstrap complete!"

# Genfstab Creation.
genfstab -U /mnt >> /mnt/etc/fstab
echo "genfstab complete!"

# Arch-chroot
arch-chroot /mnt
echo "Arch-chroot set!"

# Network Packages to be Installed.
pacman -S --needed --noconfirm networkmanager network-manager-applet nm-connection-editor bluez bluez-libs bluez-utils bluez-tools wpa_supplicant wireless_tools wireless-regdb iw iwd dhcpcd dnsutils dhclient dmraid dnsmasq openresolv tlp hddtemp smartmontools ed biber tk tcl geoip geoip-database geoip-database-extra geoipupdate geoclue plocate logrotate man-pages man-db 
echo "Network Packages installed!"

 
