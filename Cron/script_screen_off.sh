#!/bin/bash
# TODO : edit the hdmi name, just write "xrandr" and check the exact name of your output
name=HDMI-1
export DISPLAY=:0;
export XAUTHORITY=/home/linaro/.Xauthority

xrandr --output $name --off
