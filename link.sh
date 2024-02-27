#!/usr/bin/zsh

set -xe

DOTFILES_ROOT=~/.dotfiles
cd "${DOTFILES_ROOT}" || exit

find "${DOTFILES_ROOT}" -type f ! -path '*/.git/*' ! -path '*/link.sh'

