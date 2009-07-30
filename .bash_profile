keychain ~/.ssh/id_dsa
. ~/.keychain/$HOSTNAME-sh

if [ "$COLORTERM" == "gnome-terminal" ] || [ "$TERM" == "rxvt-unicode" ]; then
    export TERM=xterm-256color;
fi

alias l="ls -al"
