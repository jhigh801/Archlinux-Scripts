

# disk prep
wipefs -a  /dev/sda
sgdisk -Z  /dev/sda
sgdisk -a 2048 -o /dev/sda

# create partitions
sgdisk -n 1::2048:616447 --typecode=1:ef00 --change-name='EFIBOOT' /dev/sda1
sgdisk -n 2::616448:557410303 --typecode=2:8300 --change-name='ROOT' /dev/sda2
sgdisk -n 3::557410304:955869183 --typecpde=3:8302 --change-name='HOME' /dev/sda3
sgdisk -n 4::955869184:976773134 --typecode=4:8200 --change-name='SWAP' /dev/sda4

# make filesystems
mkfs.vfat -F32 -n 'EFIBOOT' /dev/sda1
mkfs.ext4 -n 'ROOT'  /dev/sda2
mkfs.ext4 -n 'HOME'  /dev/sda3
mkswap -n 'SWAP' /dev/sda4
swapon /dev/sda4

# Mount Target
mount /dev/sda2  /mnt
mkdir -p /mnt/{boot,home}
mount /dev/sda1  /mnt/boot
mount /dev/sda3  /mnt/HOME

# Setting System time
timedatectl set-ntp true

# connecting to the internet
iwctl

# Pacman key setup
pacman-key --init
pacman-key --populate archlinux

# reflector 
reflector  -c "United States"    --sort rate    --save  /etc/pacman.d/mirrorlist
cp /etc/pacman.d/mirrorlist   /etc/pacman.d/mirrorlist.backup

# Pacstrap
pacstrap /mnt base base-devel linux linux-firmware vim nano sudo archlinux-keyring wget libnewt --noconfirm --needed

# Setting up genfstab
genfstab -U /mnt >> /mnt/etc/fstab

# Directory switching into chroot
arch-chroot /mnt

# Setting up localtime
ln -sf /usr/share/zoneinfo/US/Eastern    >     /etc/localtime

# Configuring System Hardware Clock
hwclock --systohc

# setting up locale
nano /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8"  >  /etc/locale.conf
export LANG=en_US.UTF-8

# Creating a Hostname
echo "Arch-Plasma"  >  /etc/Hostname

# Setting up Hosts
echo "127.0.0.1     localhost"   >>  /etc/hosts
echo "::1           localhost"   >>  /etc/hosts
echo "127.0.1.1     Arch-Plasma.localdomain   Arch-Plasma" >>  /etc/hosts

# Setting up a Sudo Password
passwd root

# Creating a group
groupadd jdhighley

# Creating a User
useradd -m -g jdhighley -G sys,log,network,floppy,scanner,power,rfkill,jdhighley,video,storage,optical,lp,audio,wheel,adm   -s   /bin/bash   jon

# Setting up a Users Password
passwd jon

# Configuring the Sudoers list
EDITOR=nano visudo

# Getting the mirrorlist Sorted
pacman -S reflector rsync  --noconfirm  --needed
reflector -c "United States"   --sort rate   --save   /etc/pacman.d/mirrorlist
cp  /etc/pacman.d/mirrorlist   /etc/pacman.d/mirrorlist.backup

# downloading Grub
pacman -Sy
pacman -S grub efibootmgr efivar amd-ucode
grub-install --efi-directory=/boot   /dev/sda
grub-mkconfig -o  /boot/grub/grub.cfg

# Downloading and Installing Xorg
pacman -S  xorg xorg-server xorg-apps xorg-drivers xorg-xkill xorg-xinit xterm mesa  --noconfirm  --needed

# enabling services
pacman -S networkmanager dhcpcd iwd thermald tlp tk tcp geoio-database geoip2-database wpa_supplicant wireless_tools bluez bluez-libs  --noconfirm  --needed
sudo systemctl enable NetworkManager.service
sudo systemctl enable dhcpcd@eno1.service
sudo systemctl enable thermald.service
sudo systemctl enable tlp.service
sudo systemctl enable iwd.service
sudo systemctl enable bluetooth.service

# Leaving Chroot
exit

# Unmounting
umount -a

# Rebooting
reboot
