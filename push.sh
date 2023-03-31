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

# ------------------------------------------------------------------
# ------------------------------------------------------------------

if [ -z "$JUST" ]; then
	if [ -z "$NEW" ]; then
		git commit --amend -a -m 'master'
	else
		git commit -a -m 'master'
	fi
fi

msg 'GITHUB'
git push origin --force

msg 'FLIC'
git push flic --force

msg 'CODEBERG'
git push codeberg --force

msg 'GITLAB'
git push gitlab --force
