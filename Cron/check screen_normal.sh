#!/bin/bash
# TODO edit rotation with the rotation you want to keep
rotation=normal #can be left, right, inverted, normal
export DISPLAY=:0;
export XAUTHORITY=/home/linaro/.Xauthority

if xrandr -q --verbose | grep "$rotation ("; then
    echo ""
else
    systemctl restart lightdm.service;#restart the XServer and rerun boot script. You can also run a script that rotate the screen, but you can have issues like every time your rotate, the screen is  zoomed.
fi
