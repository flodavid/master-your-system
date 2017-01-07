#!/bin/bash


# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo "#!/bin/bash

declare -i ID
ID=\`xinput list | grep -Eio '(touchpad|glidepoint)\s*id\=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}'\`
declare -i STATE
STATE=\`xinput list-props $ID|grep 'Device Enabled'|awk '{print $4}'\`
if [ $STATE -eq 1 ]
then
    xinput --disable $ID
    # echo \"Touchpad disabled.\"
    # notify-send 'Touchpad' 'Disabled' -i /usr/share/icons/Adwaita/48x48/devices/input-touchpad.png
else
    xinput --enable $ID
    # echo \"Touchpad enabled.\"
    # notify-send 'Touchpad' 'Enabled' -i /usr/share/icons/Adwaita/48x48/devices/input-touchpad.png
fi" >> /usr/local/bin/touchpad_toggle.sh


chmod +x /usr/local/bin/touchpad_toggle.sh
