# [ tmux ]
if [[ $- == *i* ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

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

# [ prompt ]
setopt PROMPT_SUBST
autoload -Uz vcs_info
precmd() { vcs_info }
SEP="%F{250}|%f"
zstyle ':vcs_info:git:*' formats $SEP' %F{203} %b%f '  # Soft orange for git branch
PROMPT='  -%F{250}%f %F{153} %n '$SEP' %F{214}  %m%f '$SEP' %F{157}  %~%f %F{214}${vcs_info_msg_0_}%f%F{250}-%f
%B%F{214}  %f%b '
