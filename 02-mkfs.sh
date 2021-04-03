

mkfs.vfat -F32  /dev/sda1 &&
mkfs.ext4 /dev/sda2 &&
mkswap /dev/sda3 &&
swapon /dev/sda3 &&

echo "This Script is Finished !!"

