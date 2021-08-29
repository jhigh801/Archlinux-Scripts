mount /dev/sda2  /mnt &&
mkdir /mnt/{boot/efi,home} &&
mount /dev/sda1  /mnt/boot &&
mount /dev/sda3  /mnt/home &&

echo "This Script is Finished !!"

