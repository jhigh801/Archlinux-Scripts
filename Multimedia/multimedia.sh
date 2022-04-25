#!/bin/sh

## ------------------------ Multimedia-Apps {{{
sudo pacman -Syy ; sudo pacman -S --noconfirm --needed vlc mpv celluloid rhythmbox audacious audacious-plugins clementine yt-dlp atomicparsley python-pycryptodomex aria2 ffmpeg python-mutagen python-websockets rtmpdump python-certifi
## }}}

echo "This Script is now complete!"
