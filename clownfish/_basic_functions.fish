# Copyright (C) 2018 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license


function echo_and_eval --description='Echo a command line then eval it.'
  echo -n '> '; set_color cyan; echo $argv; set_color normal
  eval $argv
  return $status
end


function show_time_interval -d "Display time interval human friendly."
    if test (count $argv) -lt 1
        return
    end
    set -l day $argv[1]
    set -l ms (math "$day % 1000")
    set -l day (math "floor($day / 1000)")
    set -l second (math "$day % 60")
    set -l day (math "floor($day / 60)")
    set -l minute (math "$day % 60")
    set -l day (math "floor($day / 60)")
    set -l hour (math "$day % 24")
    set -l day (math "floor($day / 24)")
    if test $day -gt 0
        printf '%dd%dh%dm' $day $hour $minute
    else if test $hour -gt 0
        printf '%dh%dm%ds' $hour $minute $second
    else if test $minute -gt 0
        printf '%dm%ds' $minute $second
    else if test $second -gt 0
        printf '%d.%03ds' $second $ms
    else
        printf '%dms' $ms
    end
end


# 对于大多数虚拟终端，设置标题栏
if status is-interactive
    # 详情请参考 https://fishshell.com/docs/current/index.html#title
    function fish_title --description='set the message displayed in the titlebar of the terminal window'
        # 变量 `$_` 是前台的任务名称，如果没有前台任务，则为 'fish'
        if test $_ != 'fish'
            echo $_ ' '
        end
        prompt_pwd
    end
end


