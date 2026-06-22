#!/usr/bin/env bash
#
# Install the package set for an Arch Linux machine, grouped into categories.
#
# The "core" category (shell, editor, basic CLI tooling) is always installed.
# Everything else is opt-in via a flag, so a single machine only pulls in what
# it needs (e.g. only dev boxes get the IDE, only the gaming box gets Steam).
#
# AUR packages are handled transparently: if `yay` is missing it is bootstrapped
# from the AUR first, then used to install both native and AUR packages.
#
# Usage:
#   ./install.sh [--desktop] [--dev] [--gaming] [--amd-gpu]
#                [--all] [--dry-run] [-h|--help]

set -euo pipefail

# --- Package categories ------------------------------------------------------

# Always installed. Both microcode packages are included; the bootloader only
# loads the one matching the running CPU, so shipping both is harmless.
core=(
	7zip
	amd-ucode
	base
	base-devel
	btop
	fwupd
	git
	intel-ucode
	less
	linux
	linux-firmware
	man-db
	neovim
	nss-mdns
	openssh
	power-profiles-daemon
	rsync
	sshfs
	tailscale
	tmux
	wget
	zsh
	zsh-syntax-highlighting
)

# AMD GPU tooling. Skip on Nvidia/Intel graphics.
amd_gpu=(
	amdgpu_top
)

# KDE Plasma desktop, GUI applications, and media.
desktop=(
	alacritty
	ark
	cups
	dolphin
	ffmpegthumbs
	filelight
	firefox
	gwenview
	kate
	kcalc
	kdegraphics-thumbnailers
	keepassxc
	okular
	plasma-meta
	qbittorrent
	skanpage
	ttf-terminus-nerd
	vlc
	vlc-plugins-all
	yt-dlp
)

# Development tooling.
dev=(
	intellij-idea-community-edition
	jdk-openjdk
	claude-code
	python-jinja
	podman
	podman-compose
)

# Gaming.
gaming=(
	steam
)

# --- Flag parsing ------------------------------------------------------------

usage() {
	cat <<-EOF
		Usage: ${0##*/} [options]

		Installs the "core" package set always, plus any selected categories:

		  --desktop   KDE Plasma desktop, GUI apps, and media
		  --dev       Development tooling (IDE, JDK, podman, ...)
		  --gaming    Steam
		  --amd-gpu   AMD GPU tooling (amdgpu_top)
		  --all       Enable every category above
		  --dry-run   Print the resolved package list and exit
		  -h, --help  Show this help and exit
	EOF
}

want_desktop=0 want_dev=0 want_gaming=0 want_amd_gpu=0 dry_run=0

for arg in "$@"; do
	case "$arg" in
	--desktop) want_desktop=1 ;;
	--dev) want_dev=1 ;;
	--gaming) want_gaming=1 ;;
	--amd-gpu) want_amd_gpu=1 ;;
	--all) want_desktop=1 want_dev=1 want_gaming=1 want_amd_gpu=1 ;;
	--dry-run) dry_run=1 ;;
	-h | --help)
		usage
		exit 0
		;;
	*)
		echo "error: unknown option '$arg'" >&2
		usage >&2
		exit 1
		;;
	esac
done

# --- Build the install list --------------------------------------------------

packages=("${core[@]}")
selected=(core)

if ((want_amd_gpu)); then
	packages+=("${amd_gpu[@]}")
	selected+=(amd-gpu)
fi
if ((want_desktop)); then
	packages+=("${desktop[@]}")
	selected+=(desktop)
fi
if ((want_dev)); then
	packages+=("${dev[@]}")
	selected+=(dev)
fi
if ((want_gaming)); then
	packages+=("${gaming[@]}")
	selected+=(gaming)
fi

echo "Selected categories: ${selected[*]}"

# List explicitly-installed packages that the selected categories don't account
# for. These are manual installs / drift worth folding into a category (or
# removing). yay is expected here since it bootstraps the rest.
drift_report() {
	echo
	echo "Explicitly installed packages not covered by the selected categories:"
	local untracked
	untracked="$(comm -23 \
		<(pacman -Qqe | sort -u) \
		<(printf '%s\n' "${packages[@]}" | sort -u))"
	if [[ -n "$untracked" ]]; then
		printf '  %s\n' $untracked
	else
		echo "  (none)"
	fi
}

if ((dry_run)); then
	printf '%s\n' "${packages[@]}"
	drift_report
	exit 0
fi

# --- Pre-flight checks -------------------------------------------------------

if [[ $EUID -eq 0 ]]; then
	echo "error: do not run as root; makepkg refuses to build as root and pacman is called via sudo." >&2
	exit 1
fi

if ! command -v sudo >/dev/null; then
	echo "error: sudo is required." >&2
	exit 1
fi

# --- Bootstrap yay -----------------------------------------------------------

# git and base-devel are needed to build yay (and any other AUR package).
sudo pacman -S --needed --noconfirm git base-devel

if ! command -v yay >/dev/null; then
	echo "yay not found, bootstrapping from the AUR..."
	build_dir="$(mktemp -d)"
	trap 'rm -rf "$build_dir"' EXIT
	git clone https://aur.archlinux.org/yay.git "$build_dir/yay"
	(cd "$build_dir/yay" && makepkg -si --noconfirm)
fi

# --- Install -----------------------------------------------------------------

# --needed skips already-installed packages, making the script re-runnable.
yay -S --needed "${packages[@]}"

echo "Done."

drift_report
