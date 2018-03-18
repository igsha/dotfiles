#!/usr/bin/env bash

xset -q | awk '
    /Caps/{
        caps = num = scrl = "#0000FF";
        if($4 == "on") caps = "#00FF00";
        if($8 == "on") num = "#00FF00";
        if($12 == "on") scrl="#00FF00";
        print "<span color="caps">CAPS</span> <span color="num">NUM</span> <span color="scrl">SRL</span>"
    }'
