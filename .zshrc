[[ $- != *i* ]] && return # non-interactive

#{{{ colours

autoload -U colors && colors

local txtblk='[0;30m' # Black
local txtred='[0;31m' # Red
local txtgrn='[0;32m' # Green
local txtylw='[0;33m' # Yellow
local txtblu='[0;34m' # Blue
local txtpur='[0;35m' # Purple
local txtcyn='[0;36m' # Cyan
local txtwht='[0;37m' # White

local bldblk='[1;30m' # Black
local bldred='[1;31m' # Red
local bldgrn='[1;32m' # Green
local bldylw='[1;33m' # Yellow
local bldblu='[1;34m' # Blue
local bldpur='[1;35m' # Purple
local bldcyn='[1;36m' # Cyan
local bldwht='[1;37m' # White

local undblk='[4;30m' # Black
local undred='[4;31m' # Red
local undgrn='[4;32m' # Green
local undylw='[4;33m' # Yellow
local undblu='[4;34m' # Blue
local undpur='[4;35m' # Purple
local undcyn='[4;36m' # Cyan
local undwht='[4;37m' # White

local bakblk='[40m'   # Black
local bakred='[41m'   # Red
local bakgrn='[42m'   # Green
local bakylw='[43m'   # Yellow
local bakblu='[44m'   # Blue
local bakpur='[45m'   # Purple
local bakcyn='[46m'   # Cyan
local bakwht='[47m'   # White

local txtrst='[0m'    # Text Reset

c() {
  builtin printf '[38;5;%dm' $1
}

#}}}
#{{{ completion

autoload -Uz compinit
compinit

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

#}}}
#{{{ environ

export EDITOR=vim

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

#}}}
#{{{ setopt

setopt histignorealldups sharehistory
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zsh_history

bindkey -v
bindkey '^?' backward-delete-char
bindkey -M vicmd 'u' undo

autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# 10ms for escape key sequences.
KEYTIMEOUT=1

setopt autocd
setopt extendedglob
setopt interactivecomments

#}}}
#{{{ PS1

precmd() {
  PS1="%{`c 2`%}%~%{${txtrst}%}\$ "
}

#}}}
#{{{ aliases

alias ack='ack-grep -C3'
alias grep='grep --color=auto'
alias less='less -FRSXQ'
alias ls='ls --color=auto'
alias psgrep='ps aux | grep'
alias vim='vim -O'
alias g='git'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

function t() { d="/home/$USER/`date +'%Y/%m/%d'`"; mkdir -p $d && cd $d ; }

#}}}

export RUST_SRC_PATH=${HOME}/.multirust/toolchains/nightly/src

eval `keychain --eval id_rsa`

doge
