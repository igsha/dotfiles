#!/usr/bin/env bash

if [[ -z "$NNN_PIPE" ]]; then
    echo "ERROR: NNN_PIPE is empty" >&2
    exit 1
fi

printf "cd to: "
read -re VALUE
VALUE="${VALUE/#~/$HOME}" # ~ expansion
VALUE="${VALUE//\\ / }" # descape space
printf "0c%s\0" "$VALUE" > "$NNN_PIPE"
