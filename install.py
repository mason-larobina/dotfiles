#!/usr/bin/env python3
"""Install the package set for an Arch Linux machine, grouped into categories.

The "core" category (shell, editor, basic CLI tooling) is always installed.
Everything else is opt-in via a flag, so a single machine only pulls in what it
needs (e.g. only dev boxes get the IDE, only the gaming box gets Steam).

AUR packages are handled transparently: if `yay` is missing it is bootstrapped
from the AUR first, then used to install both native and AUR packages.

Usage:
    ./install.py [--desktop] [--dev] [--gaming] [--amd-gpu]
                 [--all] [--dry-run] [-h|--help]
"""

import argparse
import os
import shutil
import subprocess
import sys
import tempfile

# --- Package categories ------------------------------------------------------

# Always installed. Both microcode packages are included; the bootloader only
# loads the one matching the running CPU, so shipping both is harmless.
CORE = [
    "7zip",
    "amd-ucode",
    "base",
    "base-devel",
    "btop",
    "fwupd",
    "git",
    "intel-ucode",
    "less",
    "linux",
    "linux-firmware",
    "man-db",
    "neovim",
    "nss-mdns",
    "openssh",
    "power-profiles-daemon",
    "python",
    "rsync",
    "sshfs",
    "tailscale",
    "tmux",
    "wget",
    "zsh",
    "zsh-syntax-highlighting",
]

# AMD GPU tooling. Skip on Nvidia/Intel graphics.
AMD_GPU = [
    "amdgpu_top",
]

# KDE Plasma desktop, GUI applications, and media.
DESKTOP = [
    "alacritty",
    "ark",
    "cups",
    "dolphin",
    "ffmpegthumbs",
    "filelight",
    "firefox",
    "gwenview",
    "kate",
    "kcalc",
    "kdegraphics-thumbnailers",
    "keepassxc",
    "okular",
    "plasma-meta",
    "qbittorrent",
    "skanpage",
    "ttf-terminus-nerd",
    "vlc",
    "vlc-plugins-all",
    "yt-dlp",
]

# Development tooling.
DEV = [
    "intellij-idea-community-edition",
    "jdk-openjdk",
    "claude-code",
    "python-jinja",
    "podman",
    "podman-compose",
]

# Gaming.
GAMING = [
    "steam",
]

# Opt-in categories, in install order. (name, flag attribute, packages).
CATEGORIES = [
    ("amd-gpu", "amd_gpu", AMD_GPU),
    ("desktop", "desktop", DESKTOP),
    ("dev", "dev", DEV),
    ("gaming", "gaming", GAMING),
]


def parse_args(argv):
    parser = argparse.ArgumentParser(
        description='Installs the "core" package set always, plus any selected '
        "categories.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument(
        "--desktop", action="store_true", help="KDE Plasma desktop, GUI apps, and media"
    )
    parser.add_argument(
        "--dev", action="store_true", help="Development tooling (IDE, JDK, podman, ...)"
    )
    parser.add_argument("--gaming", action="store_true", help="Steam")
    parser.add_argument(
        "--amd-gpu", action="store_true", help="AMD GPU tooling (amdgpu_top)"
    )
    parser.add_argument(
        "--all", action="store_true", help="Enable every category above"
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Print the resolved package list and exit",
    )
    args = parser.parse_args(argv)
    if args.all:
        for _, attr, _packages in CATEGORIES:
            setattr(args, attr, True)
    return args


def resolve_packages(args):
    """Return (packages, selected category names) for the chosen flags."""
    packages = list(CORE)
    selected = ["core"]
    for name, attr, category in CATEGORIES:
        if getattr(args, attr):
            packages += category
            selected.append(name)
    return packages, selected


def drift_report(packages):
    """Print explicitly-installed packages the selected categories don't cover.

    These are manual installs / drift worth folding into a category (or
    removing). yay is expected here since it bootstraps the rest.
    """
    print()
    print("Explicitly installed packages not covered by the selected categories:")
    explicit = subprocess.run(
        ["pacman", "-Qqe"], check=True, capture_output=True, text=True
    ).stdout.split()
    untracked = sorted(set(explicit) - set(packages))
    if untracked:
        for pkg in untracked:
            print(f"  {pkg}")
    else:
        print("  (none)")


def preflight():
    if os.geteuid() == 0:
        sys.exit(
            "error: do not run as root; makepkg refuses to build as root and "
            "pacman is called via sudo."
        )
    if shutil.which("sudo") is None:
        sys.exit("error: sudo is required.")


def bootstrap_yay():
    # git and base-devel are needed to build yay (and any other AUR package).
    subprocess.run(
        ["sudo", "pacman", "-S", "--needed", "--noconfirm", "git", "base-devel"],
        check=True,
    )
    if shutil.which("yay") is not None:
        return
    print("yay not found, bootstrapping from the AUR...")
    with tempfile.TemporaryDirectory() as build_dir:
        clone = os.path.join(build_dir, "yay")
        subprocess.run(
            ["git", "clone", "https://aur.archlinux.org/yay.git", clone], check=True
        )
        subprocess.run(["makepkg", "-si", "--noconfirm"], cwd=clone, check=True)


def main(argv):
    args = parse_args(argv)
    packages, selected = resolve_packages(args)

    print(f"Selected categories: {' '.join(selected)}")

    if args.dry_run:
        for pkg in packages:
            print(pkg)
        drift_report(packages)
        return

    preflight()
    bootstrap_yay()

    # --needed skips already-installed packages, making the script re-runnable.
    subprocess.run(["yay", "-S", "--needed", *packages], check=True)

    print("Done.")
    drift_report(packages)


if __name__ == "__main__":
    main(sys.argv[1:])
