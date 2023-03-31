#!/usr/bin/env sh

COLORS="true"
enable_colors() {
    ALL_OFF="\e[1;0m"
    BOLD="\e[1;1m"
    GREEN="${BOLD}\e[1;32m"
    BLUE="${BOLD}\e[1;34m"

    PACMAN_COLORS='--color=always'
    PACCACHE_COLORS=''
    MAKEPKG_COLORS=''
}
info() {
    local mesg=$1; shift
    printf "${BLUE}  ->${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@"
}
error() {
    local mesg=$1; shift
    printf "${RED}==> ERROR:${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@"
}
msg() {
    local mesg=$1; shift
    printf "\n${GREEN}==>${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@"
}
[ "$COLORS" = "true" ] && enable_colors



if [ $# -eq 0 ]; then
	error 'password required'
	exit -1
fi
PASSWORD="$1"

HASH=$(printf '%s' "$PASSWORD" | shasum -a 512 | awk '{ print $1 }')
HASH=${HASH:0:64}
if [ "$HASH" != 'd3609460a9f66f31b2bd36661903b1424087744290285a6a6a3a68207bd0f008' ]; then
	error "wrong password"
	exit -1
fi

WORKDIR=$(dirname "$(readlink -f "$0")")
TARGET="$WORKDIR/.sanctum.sanctorum"

msg 'extracting sanctum.sanctorum'
printf 'U2FsdGVkX1+51H3BjLID3Ce576ttY7VuKOEDVnCfH7UNuCh8FcI4SeOcsB5KnqCUyKHqa1+fZVtvOM5S034VhQ==\n' | openssl aes-256-cbc -a -d -pbkdf2 -pass "pass:$PASSWORD" -out "$TARGET"
