#!/bin/bash

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

index=0
action1='numlockx on'
to_install_rodolphe=($action1);

echo "To end this, just press Ctrl+C"
echo "You will be asked to use ${to_install_rodolphe[*]}"
while true; do
    read -p "Do you wish to use ${to_install_rodolphe[$index]}?" yn
    case $yn in
        [Yy]* ) $to_install_rodolphe[$index]; index=$index+1;;
        [Nn]* ) index=$index+1;;
        * ) echo "Please answer yes or no.";;
    esac
done

