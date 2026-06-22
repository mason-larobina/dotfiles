#!/usr/bin/env bash
#
# Symlink the tracked config files into their expected locations under $HOME.
# Existing symlinks are left alone; real files are never overwritten (a warning
# is printed instead so they can be resolved manually).

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Map each repo file to the path it should be symlinked to. Most configs are
# dotfiles in $HOME; alacritty lives under the XDG config directory.
declare -A LINKS=(
	[zshrc]="$HOME/.zshrc"
	[zshenv]="$HOME/.zshenv"
	[tmux.conf]="$HOME/.tmux.conf"
	[gitconfig]="$HOME/.gitconfig"
	[alacritty.toml]="$HOME/.config/alacritty/alacritty.toml"
)

for src in "${!LINKS[@]}"; do
	source="$DOTFILES/$src"
	target="${LINKS[$src]}"

	if [[ -L "$target" ]]; then
		echo "skip existing symlink $target"
	elif [[ -e "$target" ]]; then
		echo "WARNING: $target exists and is not a symlink, manual fix required."
	else
		mkdir -p "$(dirname "$target")"
		ln -s "$source" "$target"
		echo "create link $source -> $target"
	fi
done
