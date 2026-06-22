# dotfiles

Personal configuration files for Zsh, tmux, git, and Alacritty.

## Files

| File             | Configures                  | Symlinked to               |
| ---------------- | --------------------------- | -------------------------- |
| `zshrc`          | Interactive Zsh shell       | `~/.zshrc`                 |
| `zshenv`         | Zsh environment / `PATH`    | `~/.zshenv`                |
| `tmux.conf`      | tmux (Ctrl-A prefix)        | `~/.tmux.conf`             |
| `gitconfig`      | Global git config           | `~/.gitconfig`             |
| `alacritty.toml` | Alacritty terminal          | `~/.config/alacritty.toml` |

## Setup

```sh
git clone <repo-url> ~/.dotfiles
~/.dotfiles/link.sh
```

`link.sh` symlinks each file to the location above. It skips paths that are already
symlinks and refuses to overwrite real files (it prints a warning instead).

## Install (Arch Linux)

`install.py` installs the package set for a new Arch machine. A "core" category
(shell, editor, basic CLI tooling) is always installed; everything else is opt-in
per category, so each machine only pulls in what it needs:

| Flag        | Installs                                            |
| ----------- | --------------------------------------------------- |
| *(none)*    | core: zsh, neovim, tmux, git, openssh, btop, …      |
| `--desktop` | KDE Plasma desktop, GUI apps, and media             |
| `--dev`     | Development tooling (IDE, JDK, podman, …)           |
| `--gaming`  | Steam                                               |
| `--amd-gpu` | AMD GPU tooling (`amdgpu_top`)                      |
| `--all`     | Every category above                                |

```sh
~/.dotfiles/install.py --desktop --dev               # workstation
~/.dotfiles/install.py --desktop --gaming --amd-gpu  # gaming box
~/.dotfiles/install.py                                # headless / core only
```

Use `--dry-run` to print the resolved package list without installing, or
`--help` for the full option list. AUR packages are handled automatically: if
`yay` is missing it is bootstrapped from the AUR first. The script is
re-runnable — already-installed packages are skipped.

## Dependencies

These configs assume the following are installed:

- [Neovim](https://neovim.io/) — `$EDITOR`, aliased as `vi`/`vim`
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) —
  sourced from the Arch package path `/usr/share/zsh/plugins/`
- [yt-dlp](https://github.com/yt-dlp/yt-dlp) — the `yt` alias
- `xclip` — tmux copy-mode yanks to the system clipboard
- A [Nerd Font](https://www.nerdfonts.com/) (Terminess) for Alacritty glyphs
