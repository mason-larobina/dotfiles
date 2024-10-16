autoload -Uz compinit promptinit
compinit
promptinit

# Options

setopt interactivecomments 	    # allow comments in commands

# Navigation options

setopt autocd  			        # Go to folder path without using cd.
setopt extendedglob 		    # Use extended globbing syntax.

# History options

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zsh_history

# Editor options

alias vi=nvim
alias vim=nvim
export EDITOR=nvim

# Vi-mode

bindkey -v
bindkey '^?' backward-delete-char
bindkey -M vicmd 'u' undo
export KEYTIMEOUT=1

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Alias

alias ls="ls --color=auto"

# Prompt

setopt PROMPT_SUBST
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' %F{203} %b%f '
RPROMPT='${vcs_info_msg_0_}'
PROMPT='%F{10}%~%F{220} %B> %f%b'

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
