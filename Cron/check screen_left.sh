#!/bin/bash
export DISPLAY=:0;
export XAUTHORITY=/home/linaro/.Xauthority

if xrandr -q --verbose | grep "left ("; then
    echo ""
else
    systemctl restart lightdm.service;
fi
