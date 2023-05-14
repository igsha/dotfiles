#!/usr/bin/env bash

for i in $(tr : '\n' <<< "$XDG_DATA_DIRS"); do
    __path="$i/xsessions/none+qtile.desktop"
    if [[ -r "$__path" ]]; then
        __session=$(grep -oP "^Exec=\K.*" "$__path")
        break
    fi
done

systemctl --user import-environment DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY XDG_{DATA_DIRS,RUNTIME_DIR,SESSION_ID} PATH
numlockx
kbdd
setxkbmap -layout "us,ru" -option "grp:alt_space_toggle,grp:sclk_toggle,keypad:pointerkeys"

exec "$__session"
