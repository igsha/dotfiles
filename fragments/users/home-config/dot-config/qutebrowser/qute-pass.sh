#!/usr/bin/env bash
set -e -o pipefail

QUTE_FIFO="${QUTE_FIFO:-/dev/stdout}"

sendtab() {
    echo "fake-key <Tab>" > "$QUTE_FIFO"
}

sendinsert() {
    echo "mode-enter insert" > "$QUTE_FIFO"
}

sendkeys() {
    while read -rN1 S && [[ "$S" != $'\n' ]]; do
        if [[ "$S" == " " ]]; then
            echo 'fake-key " "' > "$QUTE_FIFO"
        else
            echo "fake-key \\$S" > "$QUTE_FIFO"
        fi
    done
}

showpass() {
    PATHVAL="$1"
    if [[ -z "$PATHVAL" ]]; then
        read -r PATHVAL
    fi

    if [[ "$PATHVAL" =~ ^.+/otp$ ]]; then
        CMD="otp"
    else
        CMD="show"
    fi

    pass "$CMD" "$PATHVAL" | sendkeys
}

read -r OPTS < <(getopt -o hda --long help,detailed,all -- "$@")
eval set -- "$OPTS"

DETAILED=0
SHOWALL=0
while [[ ! -z "$1" ]]; do
    case "$1" in
        -d|--detailed) DETAILED=1; shift;;
        -a|--all) SHOWALL=1; shift;;
        -h|--help) echo "Usage: $0 [-d] <url> | -a | -h"; exit 0;;
        --) shift; URL="$1"; break;;
        *) shift;;
    esac
done

if [[ "$SHOWALL" -eq 1 ]]; then
    find $HOME/.password-store/ -name '*.gpg' -printf "%P\n" \
        | sed 's/\.gpg$//g' \
        | rofi -dmenu \
        | showpass
    exit 0
fi

URL="${URL:-$QUTE_URL}"
if [[ -z "$URL" ]]; then
    echo "URL not found. Type -h for help" >&2
    exit 2
fi

read -r DOMAIN < <(awk -F[/:] '{print $4}' <<< "$URL")
ORIGDOMAIN="$DOMAIN"
while [[ "$DOMAIN" =~ \. ]]; do
    if pass ls "websites/$DOMAIN" &> /dev/null; then
        read -r COUNT < <(pass find "websites/$DOMAIN" | grep -c "login.*")
        if ((DETAILED == 0 && COUNT < 2)); then
            showpass "websites/$DOMAIN/login"
            sendtab
            showpass "websites/$DOMAIN/password"
            sendinsert
        else
            pass ls "websites/$DOMAIN" \
                | awk '{if (NR==1) {p=$0} else {printf("%s/%s\n", p, $2)}}' \
                | rofi -dmenu \
                | showpass
            sendinsert
        fi
        exit 0
    else
        DOMAIN="${DOMAIN#*.}"
    fi
done

echo "Domain $ORIGDOMAIN not found" >&2
exit 2
