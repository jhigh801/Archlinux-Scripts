#!/bin/sh
# ------------------------- Packages {{{
sudo pacman -S --noconfirm --needed libxfce4ui libxfce4util xfce4-appfinder xfce4-artwork xfce4-battery-plugin xfce4-clipman-plugin xfce4-cpufreq-plugin xfce4-cpugraph-plugin xfce4-datetime-plugin xfce4-dict xfwm4 xfwm4-themes xfce4-diskperf-plugin xfce4-eyes-plugin xfce4-fsguard-plugin xfce4-genmon-plugin xfce4-mailwatch-plugin xfce4-mount-plugin xfce4-mpc-plugin xfce4-netload-plugin xfce4-notes-plugin xfce4-notifyd xfce4-panel xfce4-power-manager xfce4-pulseaudio-plugin xfce4-screensaver xfce4-screenshooter xfce4-sensors-plugin xfce4-session xfce4-settings xfce4-smartbookmark-plugin xfce4-systemload-plugin xfce4-taskmanager xfce4-terminal xfce4-time-out-plugin xfce4-timer-plugin xfce4-verve-plugin xfce4-wavelan-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin xfce4-xkb-plugin engrampa atril eom thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman cutefish-wallpapers 
# }}}
# ------------------------- Tools {{{
# Git & Dependencies
sudo pacman -S --noconfirm --needed git perl-authen-sasl perl-cgi perl-term-readkey perl-mediawiki-api perl-lwp-protocol-https perl-datetime-format-iso8601 org.freedesktop.secrets perl-io-socket-ssl perl-libwww python subversion asciidoc xmlto libgnome-keyring 
# }}}
# ------------------------- Additional Apps {{{
sudo pacman -S --noconfirm --needed libreoffice-still flameshot calibre gimp inkscape blender aisleriot gnome-mahjongg galculator gucharmap gnome-disk-utility firefox vivaldi vivaldi-ffmpeg-codecs rofi ffmpegthumbnailer ristretto peek gpick  
# }}}

