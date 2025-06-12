#!/usr/bin/env bash
set -e

which pw-dump jq wpctl > /dev/null

declare -A AUDIOMAPKEY
AUDIOMAPVAL=()
CNT=1
while IFS=$'\t' read -r ID NAME; do
    AUDIOMAPKEY+=(["$NAME"]="$CNT")
    AUDIOMAPVAL+=("$ID")
    ((CNT++))
done < <(pw-dump | jq -r '.[] | select(.info.props.["media.class"] == "Audio/Sink") | [.id, .info.props.["node.name"]] | @tsv')

read -r DEFAULTSINK < <(pw-dump | jq -r '.[] | select(.metadata != null) | .metadata[] | select(.key == "default.audio.sink") | .value.name')

IDX="${AUDIOMAPKEY["$DEFAULTSINK"]}"
if ((IDX == ${#AUDIOMAPVAL[@]})); then
    IDX=0
fi

wpctl set-default "${AUDIOMAPVAL[$IDX]}"
