#!/usr/bin/env bash

xset -q | awk '
    /Caps/{
        caps = num = scrl = "#0000FF";
        if($4 == "on") caps = "#00FF00";
        if($8 == "on") num = "#00FF00";
        if($12 == "on") scrl="#00FF00";
        printf "<span color=\"%s\">CAPS</span> <span color=\"%s\">NUM</span> <span color=\"%s\">SRL</span>", caps, num, scrl
    }'
