# dotfiles

Personal configuration files for Zsh, tmux, git, and Alacritty.

## Files

| File             | Configures                  | Symlinked to                          |
| ---------------- | --------------------------- | ------------------------------------- |
| `zshrc`          | Interactive Zsh shell       | `~/.zshrc`                            |
| `zshenv`         | Zsh environment / `PATH`    | `~/.zshenv`                           |
| `tmux.conf`      | tmux (Ctrl-A prefix)        | `~/.tmux.conf`                        |
| `gitconfig`      | Global git config           | `~/.gitconfig`                        |
| `alacritty.toml` | Alacritty terminal          | `~/.config/alacritty/alacritty.toml` |

## Setup

```sh
git clone <repo-url> ~/.dotfiles
~/.dotfiles/link.sh
```

`link.sh` symlinks each file to the location above. It skips paths that are already
symlinks and refuses to overwrite real files (it prints a warning instead).

## Dependencies

These configs assume the following are installed:

- [Neovim](https://neovim.io/) — `$EDITOR`, aliased as `vi`/`vim`
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) —
  sourced from the Arch package path `/usr/share/zsh/plugins/`
- [yt-dlp](https://github.com/yt-dlp/yt-dlp) — the `yt` alias
- `xclip` — tmux copy-mode yanks to the system clipboard
- A [Nerd Font](https://www.nerdfonts.com/) (Terminess) for Alacritty glyphs
