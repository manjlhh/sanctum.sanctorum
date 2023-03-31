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


WORKDIR=$(dirname "$(readlink -f "$0")")
TARGET="$WORKDIR/.sanctum.sanctorum"

while : ; do
    hash=$([ -f "$TARGET" ] && shasum -a 512 "$TARGET" | awk '{ print $1 }' || echo 0)
    hash=${hash:0:64}
    [ "$hash" = 'da78e04ead69bdff7f9a9d5eb12e8e9cc7439ac347c697b6093eba4f1b727c7a' ] && chmod 0400 "$TARGET" && break

    msg "enter $TARGET content:"
    sh -c "IFS= ;read -N 34 -s -a z; echo \$z > $TARGET"
done
