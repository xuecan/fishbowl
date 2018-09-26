# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license

# 命令提示符
# 调色板源自 https://flatuicolors.com/palette/defo
# Git 状态全开
# 显示上一条命令执行时间以及返回状态（非 0 时）
# 提示符灵感源自《海底总动员》的小丑鱼

# Powerline Symbols: █       

# fishbowl prompt color
set -g fishbowl_color_sep_root c0392b
set -g fishbowl_color_sep_user 2c3e50
set -g fishbowl_color_user_root cc0000
set -g fishbowl_color_user_user ff9900
set -g fishbowl_color_prompt_root cc0000
set -g fishbowl_color_prompt_user bdc3c7
set -g fishbowl_color_host 0087ff
set -g fishbowl_color_path 00af00
set -g fishbowl_color_php 6666ff
set -g fishbowl_color_node 00cc00
set -g fishbowl_color_jobs ffff00
set -g fishbowl_color_duration 870087
set -g fishbowl_color_status_success 00d700
set -g fishbowl_color_status_error d70000

# Fish git prompt
# https://github.com/fish-shell/fish-shell/blob/master/share/functions/__fish_git_prompt.fish
set -g __fish_git_prompt_showdirtystate 'yes'
set -g __fish_git_prompt_showstashstate 'yes'
set -g __fish_git_prompt_showuntrackedfiles 'yes'
set -g __fish_git_prompt_showupstream 'yes'
set -g __fish_git_prompt_show_informative_status 'yes'

set -g __fish_git_prompt_char_cleanstate '✓ '           # '✔'
set -g __fish_git_prompt_char_dirtystate '✻ '           # '*' '✚'
set -g __fish_git_prompt_char_invalidstate '✗ '         # '#' '✖'
set -g __fish_git_prompt_char_stagedstate '• '          # '+' '●'
set -g __fish_git_prompt_char_stashstate '§ '           # '$'
set -g __fish_git_prompt_char_stateseparator '|'        # ' ' '|'
set -g __fish_git_prompt_char_untrackedfiles '⁇ '       # '%' '…'
set -g __fish_git_prompt_char_upstream_ahead '↑ '       # '>' '↑'
set -g __fish_git_prompt_char_upstream_behind '↓ '      # '<' '↓'
set -g __fish_git_prompt_char_upstream_diverged '⥮ '    # '<>'
set -g __fish_git_prompt_char_upstream_equal '='        # '='
set -g __fish_git_prompt_char_upstream_prefix ' '       # ''

set -g __fish_git_prompt_color_branch af00ff
set -g __fish_git_prompt_color_upstream 00afff
set -g __fish_git_prompt_color_dirtystate ffff5f
set -g __fish_git_prompt_color_untrackedfiles ffaf5f
set -g __fish_git_prompt_color_cleanstate 5fff87


#function prompt_pwd --description 'Print the current working directory, shortened to fit the prompt'
#    set -l args_post
#    set -l args_pre -e 's|^/private/|/|'
#    set -l realhome ~
#    echo $PWD | /usr/bin/sed -e "s|^$realhome|~|" $args_pre -e 's-\([^/.]\)[^/]{3}/-\1/-g' $args_post
#end


function fish_prompt
    set -g -x VIRTUAL_ENV_DISABLE_PROMPT 1

    set -l color_sep
    set -l color_user
    set -l color_prompt
    set -l char_prompt
    switch (/usr/bin/whoami)
    case root toor
        set color_sep $fishbowl_color_sep_root
        set color_user $fishbowl_color_user_root
        set color_prompt $fishbowl_color_prompt_root
        set char_prompt '#'
    case '*'
        set color_sep $fishbowl_color_sep_user
        set color_user $fishbowl_color_user_user
        set color_prompt $fishbowl_color_prompt_user
        set char_prompt '$'  # ▸
    end

    echo
    # 1st line
    set_color normal; set_color $color_sep
    printf '['
    # username@hostname:path
    set_color -u
    set_color $color_user
    printf '%s' (/usr/bin/whoami)
    set_color $color_sep
    printf '@'
    set_color $fishbowl_color_host
    printf '%s' (/bin/hostname | /usr/bin/cut -d . -f 1)
    set_color normal;
    set_color $color_sep
    printf ':'
    set_color -u
    set_color $fishbowl_color_path
    printf '%s' (prompt_pwd)
    set_color normal; set_color $color_sep
    printf ']'
    # vcs
    set -l vcs (__fish_git_prompt "%s")
    if test -n "$vcs"
        set_color normal; set_color $color_sep
        printf -- '-['
        set_color $fishbowl_color_vcs
        printf '%s' $vcs
        set_color normal; set_color $color_sep
        printf ']'
    end
    printf \e'[0K'  # clear to EOL
    # 2nd line
    set_color normal; set_color $color_sep
    printf '\n`'
    # python venv
    if test -n "$VIRTUAL_ENV"
        set_color normal; set_color $color_sep
        printf -- ' '
        set_color -b 2980b9; set_color f1c40f
        if set -q PIPENV_ACTIVE
            printf ' Pipenv '
        else
            printf ' %s ' (basename $VIRTUAL_ENV)
        end
        set_color normal; set_color $color_sep
        printf ' '
    end
    # node alternative
    if test -n "$USE_NODE"
        set_color normal; set_color $color_sep
        printf -- ' '
        set_color -b 27ae60; set_color f0f0f0
        printf ' %s ' $USE_NODE
        set_color normal; set_color $color_sep
        printf ' '
    end

    #begin
    #    set_color normal; set_color $color_sep
    #    printf '─('
    #    set_color $fishbowl_color_php
    #    set -l php_version (php -r 'echo phpversion().PHP_EOL;')
    #    printf 'php %s' $php_version
    #    set_color normal; set_color $color_sep
    #    printf ')'
    #end

    #begin
    #    set_color normal; set_color $color_sep
    #    printf '─{'
    #    set_color $fishbowl_color_node
    #    set -l node_version (node -e 'console.log(process.versions.node)')
    #    printf 'Node %s' $node_version
    #    set_color normal; set_color $color_sep
    #    printf '}'
    #end
    
    # jobs
    set -l jobs_num (jobs | /usr/bin/wc -l )
    if test $jobs_num -gt 0
        set_color normal; set_color $color_sep
        printf -- '-['
        set_color $fishbowl_color_jobs
        printf '& %d' $jobs_num
        set_color normal; set_color $color_sep
        printf ']'
    end
    # prompt
    set_color normal; set_color $color_sep
    printf ' '

    # 小丑鱼
    set_color f39c12
    printf '>'
    set_color ffffff
    printf '<'
    set_color f39c12
    printf '('
    set_color ffffff
    printf '('
    set_color f39c12
    printf '('
    set_color ffffff
    printf '"'
    set_color f39c12
    printf '>'

    set_color $color_prompt
    printf '%s ' $char_prompt

    set_color normal
    printf \e'[0K'  # clear to EOL
end


function fish_right_prompt
    set -l last_status $status
    set -l last_duration $CMD_DURATION
    if begin test -z $last_duration; or test $last_duration = 0; end
        return 0
    end
    set_color -u $fishbowl_color_duration
    printf '%s' (show-millisecond $last_duration)
    set_color normal
    printf ' '
    if test $last_status = 0
        set_color $fishbowl_color_status_success
        printf '⏎ '
    else
        set_color -u $fishbowl_color_status_error
        printf '%d' $last_status
        set_color normal
        set_color $fishbowl_color_status_error
        printf '⏎ '
    end
    set_color normal
end
