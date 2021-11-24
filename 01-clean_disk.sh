# --------------- Prepping Disk for install {{{
pacman -Syy &&
pacman -S --noconfirm pacman-contrib terminus-font &&
setfont ter-22b &&


wipefs -a  /dev/sda &&
sgdisk -Z  /dev/sda &&

echo "This Script is Finished !!"

# }}}
