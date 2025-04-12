#!/bin/env bash

pacman -S --needed --noconfirm cups cups-pdf cups-pk-helper cups-filters cups-browsed python-pycups libcups libcupsfilters system-config-printer hplip python-pillow python-reportlab gutenprint ghostscript foomatic-db foomatic-db-engine foomatic-db-gutenprint foomatic-db-nonfree foomatic-db-nonfree-ppds foomatic-db-ppds &&

systemctl enable cups.service &&
systemctl enable cups-browsed.service &&

echo "This Script is now finished!"