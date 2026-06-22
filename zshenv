# Environment for all Zsh shells (login, interactive, scripts). Symlinked to
# ~/.zshenv (see link.sh). Keeps PATH unique and adds the Rust/cargo and local
# user bin directories.

typeset -U path PATH
path=(~/.cargo/bin ~/.local/bin $path)
export PATH
. "$HOME/.cargo/env"
