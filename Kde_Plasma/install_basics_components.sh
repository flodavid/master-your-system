#!/bin/bash

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

index=0
to_install_rodolphe=('bumblebee' 'git' 'xinput' 'opera' 'nano' 'gparted');

echo -e "To end this, just tape quit\n"
echo "You will be asked to install ${to_install_rodolphe[*]}"
while true; do
    read -p "Do you wish to install ${to_install_rodolphe[$index]}?" ynq
    case $ynq in
        [Yy]* ) zypper in ${to_install_rodolphe[$index]}; index=$index+1;;
        [Nn]* ) index=$index+1;;
        [Qq]* ) break;;
        * ) echo "Please answer yes or no or quit.";;
    esac
done

