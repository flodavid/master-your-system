#!/bin/bash

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo "http://askubuntu.com/questions/594068/fnf5-f6-keys-to-adjust-brightness-doesnt-work"

echo "You will need to copy paste some things after, be prepare (it use nano), install it before if you don't already have it"

echo "Change GRUB_CMDLINE_LINUX_DEFAULT=\"quiet splash\"
to
GRUB_CMDLINE_LINUX_DEFAULT=\"quiet splash pcie_aspm=force acpi_osi=\" "
echo "Are you ready ? (Press a key to continue)"
read plop;

sudo nano /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg

echo 'Copy & Paste the following lines into the next document;

Section "Device"
    Identifier "card0"
    Driver "intel"
    Option "Backlight" "intel_backlight"
    BusID "PCI:0:2:0"
EndSection
'
echo "Are you ready ? (Press a key to continue)"
read plop;

cd /usr/share/X11/xorg.conf.d
sudo touch 20-intel.conf
sudo nano 20-intel.conf

echo "now you need to reboot, good job!"
