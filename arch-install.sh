#!/usr/env/bash
# ==============================================================================
# Arch Linux Btrfs & Zram Installation Script (HDD Target)
# ==============================================================================

set -euo pipefail

# Update target device to match standard HDD naming (e.g., /dev/sda2)
TARGET_DEV="/dev/sda2"  
MOUNT_POINT="/mnt"

echo "[*] Mounting Btrfs root subvolume with HDD optimizations..."
# Note: 'autodefrag' helps mechanical drives reduce fragmentation from CoW, 
# and 'ssd' option is omitted.
mount -o noatime,compress=zstd,space_cache=v2,autodefrag "$TARGET_DEV" "$MOUNT_POINT"

# Create Btrfs Subvolumes
echo "[*] Creating Btrfs subvolumes..."
btrfs subvolume create "$MOUNT_POINT/@"
btrfs subvolume create "$MOUNT_POINT/@home"
btrfs subvolume create "$MOUNT_POINT/@log"
btrfs subvolume create "$MOUNT_POINT/@pkg"

# Unmount and remount with correct subvolume layout
umount "$MOUNT_POINT"

echo "[*] Mounting subvolumes to final layout..."
mount -o noatime,compress=zstd,space_cache=v2,autodefrag,subvol=@ "$TARGET_DEV" "$MOUNT_POINT"
mkdir -p "$MOUNT_POINT"/{home,var/log,var/cache/pacman/pkg,boot}

mount -o noatime,compress=zstd,space_cache=v2,autodefrag,subvol=@home "$TARGET_DEV" "$MOUNT_POINT/home"
mount -o noatime,compress=zstd,space_cache=v2,autodefrag,subvol=@log "$TARGET_DEV" "$MOUNT_POINT/var/log"
mount -o noatime,compress=zstd,space_cache=v2,autodefrag,subvol=@pkg "$TARGET_DEV" "$MOUNT_POINT/var/cache/pacman/pkg"

# Mount EFI Partition (Assumed sda1)
mount /dev/sda1 "$MOUNT_POINT/boot"

# Generate fstab
genfstab -U "$MOUNT_POINT" >> "$MOUNT_POINT/etc/fstab"

echo "[*] Base structure ready for chroot and package installation!"
