#!/bin/sh

## ------------------------ Printer Apps {{{
sudo pacman -Syy ; sudo pacman -S --noconfirm --needed cups cups-pk-helper cups-filters cups-pdf python-pycups libcups python system-config-printer foomatic-db foomatic-db-engine foomatic-db-gutenprint-ppds ghostscript gutenprint dialog hplip python-pillow python-reportlab python-dbus sane python-pyqt5

## enabling Cups into Systemd
sudo systemctl enable cups.service
sudo systemctl enable cups-browsed.service
echo "This Script is Complete!"
## }}}
