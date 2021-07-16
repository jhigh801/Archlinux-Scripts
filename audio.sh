#!/bin/sh

sudoab pacman -S --needed pulseaudio pavumeter pavucontrol paprefs pasystray pulseaudio-alsa pulseaudio-equalizer-ladspa alsa-utils alsa-plugins alsa-firmware gstreamer gst-plugins-good gst-plugins-bad gst-plugins-base gst-plugins-base-libs pulseaudio-bluetooth gst-libav gst-plugins-ugly gstreamer-vaapi xvidcore frei0r-plugins cdrdao dvdauthor transcode pulseaudio-jack ffmpegthumbnailer ffmpeg faad2 libdvdcss flac mjpegtools x265 x264 lame mencoder &

# Enabling Audio Features
sudo systemctl enable pulseaudio.socket &

echo "This Script is Finished!"



