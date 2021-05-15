# Defined interactively
function fish_prompt --description 'Informative prompt'
    #Save the return status of the previous command
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

    if functions -q fish_is_root_user; and fish_is_root_user
        printf '%s@%s %s%s%s# ' \
            $USER \
            (prompt_hostname) \
            (set -q fish_color_cwd_root and set_color $fish_color_cwd_root or set_color $fish_color_cwd) \
            (prompt_pwd) \
            (set_color normal)
    else
        set -l pipestatus_string (__fish_print_pipestatus "[" "] " "|" (set_color $fish_color_status) \
                                  (set_color --bold $fish_color_status) $last_pipestatus)

        set -g fish_prompt_pwd_dir_length 0

        printf '%s %s%s@%s %s\n%s%s > ' \
            (date "+%H:%M:%S") \
            (set_color brblue) \
            $USER \
            (prompt_hostname) \
            $pipestatus_string \
            (set_color $fish_color_cwd) \
            (prompt_pwd) \
            (set_color normal)
    end
end
