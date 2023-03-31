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

HASH=$(printf '%s' "$1" | shasum -a 512 | awk '{ print $1 }')
HASH=${HASH:0:64}
if [ "$HASH" != 'abf9c11b33a42bc576694f7ec0b891e1f780c12811f4032018ba9b5f98dfee15' ]; then
	error "wrong password"
	exit -1
fi

WORKDIR=$(dirname "$(readlink -f "$0")")
TARGET="$WORKDIR/dec/sanctum.sanctorum.kdbx"
ENC_FILE="$WORKDIR/sanctum.sanctorum.enc"

if [ ! -f "$TARGET" ]; then
	error "no file $TARGET"
	exit -1
fi

msg 'encrypting'
openssl aes-256-cbc -pass "pass:$1" -salt -pbkdf2 -in "$TARGET" -out "$ENC_FILE"
