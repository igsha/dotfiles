#!/usr/bin/env bash

while read line; do
    status=`xset q | grep "LED mask" | awk '{print $NF}'`
    echo "$line | $status"
done

