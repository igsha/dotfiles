#!/bin/bash

export DISPLAY=:0.0

hdmi_display=`xrandr -q | grep " connected" | awk '{print $1}' | grep HDMI`
dpf_display=`xrandr -q | grep " connected" | awk '{print $1}' | grep DP`
dvi_display=`xrandr -q | grep " connected" | awk '{print $1}' | grep DVI`
vga_display=`xrandr -q | grep " connected" | awk '{print $1}' | grep VGA`
lvds_display=`xrandr -q | grep " connected" | awk '{print $1}' | grep LVDS`
cur_display=`xrandr -q | grep " connected" | grep -E ".* connected [[:digit:]x\+]+" | awk '{print $1}'`

# choose appropriate display
disp=$lvds_display
if [[ "0$hdmi_display" != "0" ]]; then
    disp=$hdmi_display
elif [[ "0$dpf_display" != "0" ]]; then
    disp=$dpf_display
elif [[ "0$dvi_display" != "0" ]]; then
    disp=$dvi_display
elif [[ "0$vga_display" != "0" ]]; then
    disp=$vga_display
fi

if [[ "0$cur_display" != "0$disp" ]]; then
    # turn off current display and set correct one
    for d in `xrandr -q | grep " connected" | awk '{print $1}'`; do
        xrandr --output $d --off
    done
    xrandr --output $disp --auto --primary
fi

