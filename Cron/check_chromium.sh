#!/bin/bash
# TODO : edit the process name
name="chromium/chromium"
export DISPLAY=:0;
if ps -aux | grep -F $name | grep -Fv color | grep -Fv grep; then
    echo ""
else
    systemctl restart lightdm.service;#restart the XServer and rerun boot scripts
fi
