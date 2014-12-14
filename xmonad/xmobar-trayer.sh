#!/bin/bash

ps -C trayer --no-header >/dev/null && killall trayer

function start_later()
{
    SLEEP_PARAM=0.23
    while { ! xprop -name xmobar &>/dev/null; }; do
        sleep $SLEEP_PARAM
    done

    read -a XMOBAR_HW <<< `xprop -name xmobar | grep NET_WM_STRUT_PARTIAL | awk -F ',' '{print $3,$9}'`
    trayer --edge top --align left \
           --SetDockType true --expand true \
           --widthtype pixel --width ${XMOBAR_HW[1]} \
           --transparent true --alpha 0 --tint 0x444444 \
           --heighttype pixel --height ${XMOBAR_HW[0]}
}

start_later &>>~/.xsession-errors &
