# Export environ vars.
export EDITOR="vim"
export PATH="~/bin:$PATH"
export XDG_DATA_HOME="/home/$USER/.local/share"
export XDG_CONFIG_HOME="/home/$USER/.config"
export XDG_CACHE_HOME="/home/$USER/.cache"
export XDG_DOWNLOAD_DIR="/home/$USER/downloads"

# Erase history duplicates, store 10k lines, append hist
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend

# Check for an interactive session
[ -z "$PS1" ] && return

# Load keychain
keychain id_dsa
. ~/.keychain/$HOSTNAME-sh
clear

alias ls='ls --color=auto'
alias l='ls --color=auto -Glh'
alias xr='xrdb -all ~/.Xresources'
alias ack="ack -a -C 3"
alias mklk="make clean && USE_UNIQUE=0 USE_LUAJIT=1 CC=clang make luakit -j4"

# Load colours for PS1
. ~/bin/bash_colours.sh

function minutes_since_last_commit {
    now=`date +%s`
    last_commit=`git log --pretty=format:'%at' -1`
    seconds_since_last_commit=$((now-last_commit))
    minutes_since_last_commit=$((seconds_since_last_commit/60))
    echo $minutes_since_last_commit
}

grb_git_prompt() {
    local g="$(__gitdir)"
    if [ -n "$g" ]; then
        local LAST=`minutes_since_last_commit`

        if [ "$LAST" -gt 43200 ]; then
            local COLOR=${txtred}
            local SINCE_LAST_COMMIT="${COLOR}$((LAST/43200))M${txtrst}"

        elif [ "$LAST" -gt 1440 ]; then
            local COLOR=${txtblu}
            local SINCE_LAST_COMMIT="${COLOR}$((LAST/1440))d${txtrst}"

        elif [ "$LAST" -gt 60 ]; then
            local COLOR=${txtpur}
            local SINCE_LAST_COMMIT="${COLOR}$((LAST/60))h${txtrst}"

        else
            local COLOR=${txtgrn}
            local SINCE_LAST_COMMIT="${COLOR}${LAST}m${txtrst}"
        fi

        # The __git_ps1 function inserts the current git branch where %s is
        local GIT_PROMPT=`__git_ps1 "(%s ${SINCE_LAST_COMMIT})"`
        echo "${GIT_PROMPT} "
    fi
}

PS1="\[${txtgrn}\]\w\[${txtrst}\] \$(grb_git_prompt)\[${txtblu}\]>\[${txtrst}\] "
PS2="\[${txtgrn}\]. \[${txtrst}\]"

source ~/bin/git-completion.bash
