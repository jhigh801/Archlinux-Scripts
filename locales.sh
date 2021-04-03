

nano /etc/locale.gen  &&
locale-gen &&
echo LANG=en_US.UTF-8  > /etc/locale.conf &&
export LANG=en_US.UTF-8 &&
echo "Script is done !!"

