#!/usr/bin/env bash
set -e
shopt -s lastpipe

which http jq jo >/dev/null

declare -A WEATHER_ICONS=(\
    [sunny]="☀️" \
    [partly_coudy]="🌤️" \
    [cloudy]="🌥️" \
    [very_cloudy]="☁️" \
    [light_shower]="🌦️" \
    [rain]="🌧️" \
    [thundery_shower]="🌩️" \
    [fog]="🌫️" \
    [snow]="❄️" \
    [unknown]="☓" \
)

geticonname() {
    if (( ($1 >= 293 && $1 <= 377) || ($1 >= 395 && $1 <= 431) )); then
        echo rain
        return
    fi

    case "$1" in
        113) echo sunny;;
        116) echo partly_coudy;;
        119) echo cloudy;;
        122) echo very_cloudy;;
        143|248|260) echo fog;;
        176|281|284) echo light_shower;;
        179|182|185|263|266) echo rain;;
        200|386|389|392) echo thundery_shower;;
        227|230) echo snow;;
        *) echo unknown;;
    esac
}

http "https://wttr.in/?format=j2" \
    | jq '.current_condition[0]' \
    | mapfile JSON

<<< "${JSON[@]}" jq -r '.weatherCode, .temp_C, .weatherDesc[0].value' \
    | { read -r WEATHER_CODE; read -r TEMPERATURE; read -r DESCRIPTION; }

geticonname "$WEATHER_CODE" \
    | read -r WEATHER_NAME

{
    <<< "${JSON[@]}" jq -r '.weatherDesc=.weatherDesc[0].value | del(.weatherIconUrl) | to_entries[] | [.key, .value] | @tsv'
    printf "\0"
} | IFS= read -r -d '' TOOLTIP_TEXT

jo text="${WEATHER_ICONS[$WEATHER_NAME]} $TEMPERATURE" alt="$DESCRIPTION" tooltip="$TOOLTIP_TEXT" class=none
