#!/usr/bin/env bash


for c in {0..7}; do
    __str_low+="$(tput setaf $c)██████$(tput setaf sgr0)"
    __str_high+="$(tput setaf $((c+8)))██████$(tput setaf sgr0)"
done

printf "      black  red  green yellow blue purple cyan white\n"
printf "low:  %s\n" "$__str_low"
printf "$(tput setaf 7)high: %s\n" $__str_high
