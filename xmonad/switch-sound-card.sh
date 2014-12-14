#!/bin/bash

CARD_AND_PROFILE=(`pactl list short sinks | awk '{print $2}' | sed 's/\(.*\)\.\(\w\+\)/\1 \2/g'`)
CARD_PATTERN=`echo ${CARD_AND_PROFILE[0]} | sed 's/^\w\+\.//g'`
CARD=`pactl list short cards | grep $CARD_PATTERN | awk '{print $2}'`
PROFILE=${CARD_AND_PROFILE[1]}

HDMI_PROFILE="output:hdmi-stereo+input:analog-stereo"
ANALOG_PROFILE="output:analog-stereo+input:analog-stereo"

if grep -q "output:$PROFILE" <<< $HDMI_PROFILE; then
    pactl set-card-profile $CARD $ANALOG_PROFILE
elif grep -q "output:$PROFILE" <<< $ANALOG_PROFILE; then
    pactl set-card-profile $CARD $HDMI_PROFILE
fi
