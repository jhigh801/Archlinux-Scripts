#!/bin/env bash

pacman -S --needed --noconfirm grub efibootmgr efivar dosfstools jfsutils sysfsutils erofs-utils exfat-utils exfatprogs	nfs-utils nilfs-utils intel-ucode amd-ucode f2fs-tool elfutils &&

echo "This Script is now finished!"