#!/bin/sh

## ----------------------Grub {{{
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --recheck  /dev/sda
grub-mkconfig -o  /boot/grub/grub.cfg
## }}}

echo "This Script is now complete!"
