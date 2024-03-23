#!/usr/bin/env bash
set -e

which openssl uuidgen >/dev/null

printhelp() {
    if [[ -n "$1" ]]; then
        echo "Error: $1" >&2
    fi

    echo "Usage: $0 -s <server> -l <login> [-p <password>] [-o '<sslopts>'] | -h"
    echo "Options:"
    echo "  -s|--server -- connect to imap <server>"
    echo "  -l|--login -- <login> of the email account"
    echo "  -p|--password -- <password> of the email account. Can be read from stdin"
    echo "  -o|--options -- pass additional <sslopts> flags to openssl. Escape by quotes"
    echo "                  Example: -o '-cipher ALL:@SECLEVEL=0'"
    echo "  -h|--help -- show this help"
    echo
    echo "Notes: use 'iconv -f UTF-7-IMAP -t UTF-8' command to parse cyrillic titles."
}

eval set -- $(getopt -o s:l:p:o:h -l server:login:password:options:help -- "$@")
while true; do
    case "$1" in
        -s|--server) SERVER="$2"; shift 2;;
        -l|--login) USERLOGIN="$2"; shift 2;;
        -p|--password) USERPASS="$2"; shift 2;;
        -o|--options) readarray -d' ' -t SSLOPTIONS <<< "$2"; shift 2;;
        -h|--help) printhelp; exit 0;;
        --) shift; break;;
        *) printhelp; exit 1;;
    esac
done

if [[ -z "$USERLOGIN" || -z "$SERVER" ]]; then
    printhelp "server or login is not set"
    exit 2
fi

if [[ -z "$USERPASS" ]]; then
    read -p "Password: " -s USERPASS
    echo
fi

coproc openssl s_client "${SSLOPTIONS[@]}" -connect "$SERVER:993" -crlf -quiet 2>/dev/null

sendmessage() {
    UUID=$(uuidgen)
    echo $UUID "$@" >&${COPROC[1]}
    while read -u ${COPROC[0]} -r line; do
        echo "$line"
        if [[ "$line" =~ "$UUID OK" || "$line" =~ "$UUID BAD" ]]; then
            break
        fi
    done
}

sendmessage login "$USERLOGIN" "$USERPASS"
sendmessage 'list "" "*"'
sendmessage logout
