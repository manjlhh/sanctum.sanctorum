#!/usr/bin/env sh

WORKDIR=$(dirname "$(readlink -f "$0")")
cd "$WORKDIR"

git remote set-url origin git@github.com:manjlhh/sanctum.sanctorum.git
git remote add gitlab git@gitlab.com:manjlhh/sanctum.sanctorum.git
git remote add codeberg git@codeberg.org:manjlhh/sanctum.sanctorum.git
git remote add flic git@gitflic.ru:manjlhh/sanctum-sanctorum.git
