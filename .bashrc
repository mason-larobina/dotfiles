[[ -f /etc/profile.d/bash-completion ]] &&  source /etc/profile.d/bash-completion

export HISTTIMEFORMAT="%s "

PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'echo $$ $USER \ "$(history 1)" >> ~/.bash_permanent_history'

source ~/.bash_profile

export PATH="~/.bin:$PATH"
