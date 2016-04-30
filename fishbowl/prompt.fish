# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license

# Powerline Symbols: █       
''

set -g fishbowl_color_sep_root 870000
set -g fishbowl_color_sep_user 005f5f
set -g fishbowl_color_user_root d70000
set -g fishbowl_color_user_user ff8700
set -g fishbowl_color_prompt_root d70000
set -g fishbowl_color_prompt_user ff8700
set -g fishbowl_color_host 0087ff
set -g fishbowl_color_path 00af00
set -g fishbowl_color_vcs ff005f
set -g fishbowl_color_python 878700
set -g fishbowl_color_jobs ffff00
set -g fishbowl_color_duration 870087
set -g fishbowl_color_status_success 00d700
set -g fishbowl_color_status_error d70000


function _prompt_svn_info
  svn info >/dev/null ^/dev/null; or return 0
  printf 'svn'
  set -l modified (svn status | wc -w)
  test $modified -gt 0; and printf '*'
end


function prompt_pwd --description 'Print the current working directory, shortened to fit the prompt'
  set -l args_post
  set -l args_pre -e 's|^/private/|/|'
  set -l realhome ~
  echo $PWD | sed -e "s|^$realhome|~|" $args_pre -e 's-\([^/.]\)[^/]{3}/-\1/-g' $args_post
end


function fish_prompt
  set -g -x VIRTUAL_ENV_DISABLE_PROMPT 1

  set -l color_sep
  set -l color_user
  set -l color_prompt
  set -l char_prompt
  switch (whoami)
  case root toor
    set color_sep $fishbowl_color_sep_root
    set color_user $fishbowl_color_user_root
    set color_prompt $fishbowl_color_prompt_root
    set char_prompt '#'
  case '*'
    set color_sep $fishbowl_color_sep_user
    set color_user $fishbowl_color_user_user
    set color_prompt $fishbowl_color_prompt_user
    set char_prompt '$'
  end

  echo
  # 1st line
  set_color normal; set_color $color_sep
  printf '┌─['
  # username@hostname:path
  set_color -u
  set_color $color_user
  printf '%s' (whoami)
  set_color $color_sep
  printf '@'
  set_color $fishbowl_color_host
  printf '%s' (hostname|cut -d . -f 1)
  set_color normal;
  set_color $color_sep
  printf ':'
  set_color -u
  set_color $fishbowl_color_path
  printf '%s' (prompt_pwd)
  set_color normal; set_color $color_sep
  printf ']'
  # vcs
  set -l vcs (_prompt_svn_info)
  if test -n "$vcs"
    set_color normal; set_color $color_sep
    printf '-{'
    set_color $fishbowl_color_vcs
    printf '%s' $vcs
    set_color normal; set_color $color_sep
    printf '}'
  end
  # 2nd line
  set_color normal; set_color $color_sep
  printf '\n└'
  # python venv
  if test -n "$VIRTUAL_ENV"
    set_color normal; set_color $color_sep
    printf '─['
    set_color $fishbowl_color_python
    printf '🐍 %s' (basename $VIRTUAL_ENV)
    set_color normal; set_color $color_sep
    printf ']'
  end
  # jobs
  set -l jobs_num (jobs | wc -l )
  if test $jobs_num -gt 0
    set_color normal; set_color $color_sep
    printf '─['
    set_color $fishbowl_color_jobs
    printf '📍 %d' $jobs_num
    set_color normal; set_color $color_sep
    printf ']'
  end
  # prompt
  set_color normal; set_color $color_sep
  printf '⇾ '
  set_color $color_user
  printf '%s ' $char_prompt
  set_color normal
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
