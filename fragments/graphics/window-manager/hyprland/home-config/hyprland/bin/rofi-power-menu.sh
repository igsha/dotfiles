#!/usr/bin/env bash
set -e

powermenu() {
    declare -A MENU=()
    MENU["1 lock"]="loginctl lock-session ${XDG_SESSION_ID-}"
    MENU["2 reload"]="hyprctl reload"
    MENU["3 suspend"]="systemctl suspend"
    MENU["4 hibernate"]="systemctl hibernate"
    MENU["5 logout"]="loginctl terminate-session ${XDG_SESSION_ID-}"
    MENU["6 reboot"]="systemctl reboot"
    MENU["7 poweroff"]="systemctl poweroff"

    if [[ -n "$1" ]]; then
        ${MENU[$1]} 1>&2
    else
        echo -en "\0prompt\x1fPower menu\n"
        echo -en "\0data\x1fpowermenu\n"
        printf "%s\n" "${!MENU[@]}" | sort
    fi
}

if [[ -n "$ROFI_DATA" ]]; then
    $ROFI_DATA "$@"
else
    powermenu "$@"
fi
