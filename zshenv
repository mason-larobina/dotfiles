typeset -U path PATH
path=(~/.cargo/bin ~/.local/bin $path)
export PATH
. "$HOME/.cargo/env"
