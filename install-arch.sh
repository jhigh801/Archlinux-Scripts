#!/usr/bin/env bash
set -euo pipefail

# Define your target disk (Change /dev/sda if your laptop sees it differently)
DISK="/dev/sda"

echo "Wiping $DISK..."
sgdisk --zap-all "$DISK"

echo "Creating partitions based on your 500GB layout..."

# 1. Boot: 2 GiB (Type: ef00 - EFI System Partition)
sgdisk -n 1:0:+2G -t 1:ef00 "$DISK"

# 2. Root: 220 GiB (Type: 8304 - Linux x86-64 root)
sgdisk -n 2:0:+220G -t 2:8304 "$DISK"

# 3. Home: 230 GiB (Type: 8302 - Linux /home)
sgdisk -n 3:0:+230G -t 3:8302 "$DISK"

# 4. Swap: Remaining space (~13.8 GiB) (Type: 8200 - Linux swap)
sgdisk -n 4:0:0 -t 4:8200 "$DISK"

# Notify kernel of partition changes
udevadm settle

echo "Formatting partitions..."
mkfs.fat -F 32 "${DISK}1"
mkfs.ext4 "${DISK}2"
mkfs.ext4 "${DISK}3"
mkswap "${DISK}4"
swapon "${DISK}4"

echo "Disk partitioning and formatting complete!"

# Mounting Root, then creating and mounting the rest
mount /dev/sda2 /mnt && echo "/mnt is mounted on /dev/sda2"
mount --mkdir /dev/sda1 /mnt/boot/efi && echo "/mnt/boot/efi is mounted on /dev/sda1"
mount --mkdir /dev/sda3 /mnt/home && echo "/mnt/home is mounted on /dev/sda3"

# Timedatectl set up.
echo "Setting up time and date..."
# Ensure Network Time Protocol (NTP) is active
timedatectl set-ntp true

# Set the hardware clock to UTC (Arch Linux standard)
timedatectl set-local-rtc 0
echo "Setting up time and date complete..."
# (Optional) If you want to force an immediate sync 
# instead of waiting for the daemon:
# ntpd -qg

echo "Setting up time and date complete..."

# Pacman-Key Setup
sudo pacman -Sy --noconfirm haveged && sudo systemctl start haveged
sudo pacman -Sy archlinux-keyring
echo "Pacman-Key Setup complete."

# Reflector 
# Backup the original first
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak

# Run reflector
sudo reflector --country US --latest 15 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# 1. You edit the Live ISO's config (which you've already done)
# 2. Run pacstrap...
pacstrap -K /mnt base base-devel linux-lts linux-lts-headers linux-firmware networkmanager network-manager-applet nm-connection-editor iw iwd openresolv reflector rsync amd-ucode git neovim grub efibootmgr efivar dosfstools os-prober mtools e2fsprogs usbutils jfsutils xfsprogs f2fs-tools   
echo "pacstrap is done."

# 3 Genfstab - getting up the fstab
genfstab -U /mnt >> /mnt/etc/fstab && echo "fstab is now generated!"

# 4. Overwrite the default config with your "good" one
cp /etc/pacman.conf /mnt/etc/pacman.conf && echo "pacman config is now backed up!"

# 5. Start the ONLY arch-chroot block
arch-chroot /mnt <<EOF

# 1. Initialize Keys
pacman-key --init
pacman-key --populate archlinux

# 2. Network & Identity
echo "Arch-Laptop-2" > /etc/hostname
systemctl enable NetworkManager

# 3. Time & Locale (Fort Wayne + 24-Hour Format)
ln -sf /usr/share/zoneinfo/America/Fort_Wayne /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "en_DK.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "LC_TIME=en_DK.UTF-8" >> /etc/locale.conf
echo "LC_MEASUREMENT=en_US.UTF-8" >> /etc/locale.conf

# 4. User Setup
echo "Setting Root Password..."
passwd
useradd -m -G wheel jon
echo "Setting User Password for jon..."
passwd jon

# 5. Enable Sudo for the Wheel Group
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# 6. Install GRUB (Bootloader)
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader=GRUB --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

EOF
# END OF SCRIPT
