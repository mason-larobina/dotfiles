#!/usr/bin/zsh

DOTFILES=~/.dotfiles

cd "${DOTFILES}" || exit

find "${DOTFILES}" -type f ! -path '*/.git/*' ! -path '*/link.sh' -print0 | \
	while IFS= read -r -d $'\0' source; do
		target="$HOME/${source#$DOTFILES/}"
		if [[ ! -e "${target}" ]]; then
			ln -s "${source}" "${target}"
			echo "create link ${source} -> ${target}"
		elif [[ -L "${target}" ]]; then
			echo "skip existing symlink ${target}"
		else
			echo "WARNING: ${target} exists and is not a symlink, manual fix required."
		fi
	done
