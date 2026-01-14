#!/usr/bin/env bash

# Networking {{{
sudo pacman -S --needed --noconfirm networkmanager network-manager-applet nm-connection-editor bluez bluez-libs bluez-utils bluez-tools python-pybluez dnsmasq dhclient dnsutils geoip geoip-database geoip-database-extra geoipupdate dhcpcd openresolv reflector rsync iw iwd ed tlp smartmontools hddtemp wpa-supplicant wireless-regdb wireless_tools libmaxminddb python-geoip python-geoip2 python-geoipsets php-geoip perl-geoip &
# }}}

# Multimedia {{{
sudo pacman -S --needed --noconfirm pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-jack pavucontrol pasystray paprefs vlc vlc-all mpv celluloid gst-plugins-bad gst-plugins-good gst-plugins-ugly gst-libav libdvdcss libdvdread alsa-card-profiles alsa-firmware alsa-utils alsa-plugins alsa-tools & 
# }}}

# Compression {{{
sudo pacman -S --needed --noconfirm atool xarchiver unarchiver bzip2 cpio gzip lhasa xz lzop 7zip tar arj unarj unace lzip unrar zip unzip lrzip lz4 xdg-utils zstd &
# }}}

# Graphics {{{
sudo pacman -S --needed --noconfirm blender inkscape imagemagick gpick peek gimp ristretto feh ffmpegthumbnailer tumbler fastfetch chafa catimg libwmf libraw djvulibre libultrahdr &
# }}}

# Terminal-based Web-Browsers {{{
sudo pacman -S --needed --noconfirm w3m elinks lynx xterm alacritty kitty python-pygments libcanberra ncurses &
# }}}

# File Managers {{{
sudo pacman -S --needed --noconfirm ranger transmission-cli ueberzug odt2txt perl-image-exiftool perl-archive-zip perl-io-compress-brotli highlight mediainfo libcaca figlet thunar thunar-volman thunar-archive-plugin  thunar-media-tags-plugin thunar-shares-plugin thunar-vcs-plugin gvfs gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-onedrive gvfs-smb 
