function fish_prompt
    set -g fish_prompt_pwd_dir_length 0
    printf "%s%s" (set_color 444) (date "+%H:%M:%S")
    printf " %s@%s" $USER (prompt_hostname)
    printf "\n%s%s %s> " (set_color 00FF00) (prompt_pwd) (set_color normal)
end
