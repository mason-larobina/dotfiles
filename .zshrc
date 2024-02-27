# [ options ]
setopt AUTO_CD
setopt EXTENDED_GLOB

# [ history ]
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt INTERACTIVE_COMMENTS
setopt SHARE_HISTORY

# [ editor ]
alias vi=nvim
alias vim=nvim
export EDITOR=nvim

# [ alias ]
alias g='git'
alias less='less -FRSXQ'
alias ls='ls --color=auto'

# [ vi-mode ]
bindkey -v

autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# [ tmux ]
if [[ $- == *i* ]] && [ -z "$TMUX" ]; then
  exec tmux
fi
