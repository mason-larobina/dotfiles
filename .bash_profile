[[ -f /etc/profile.d/bash-completion ]] &&  source /etc/profile.d/bash-completion

# Load ssh keys using the keychain tool.
keychain ~/.ssh/id_dsa
. ~/.keychain/$HOSTNAME-sh
clear

# Enable 256 colour support.
if [ "$COLORTERM" == "gnome-terminal" ] || [ "$TERM" == "rxvt-unicode" ]; then
    export TERM=xterm-256color;
fi

# Env variables.
PS1='\[\e[40m\]\[\e[1;37m\] \u \[\e[47m\]\[\e[1;30m\] \w \[\e[0m\]\[\e[1;37m\]\[\e[42m\] > \[\e[0m\] '
PATH="~/.bin/:$PATH"

# Load aliases
source .aliases
