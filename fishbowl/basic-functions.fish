# Copyright (C) 2018 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license


function echo-and-eval --description='echo a command line then eval it'
  echo -n '> '; set_color cyan; echo $argv; set_color normal
  eval $argv
  return $status
end


function listutil -d "invoke `listutil.py'"
  eval "$FISHBOWL_BASEDIR/listutil.py $argv"
  return $status
end


function show-millisecond -d "invoke `show-millisecond.py'"
  eval "$FISHBOWL_BASEDIR/show-millisecond.py $argv"
  return $status
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


#for i in (seq 1 9)
#    eval 'function %$i --description=\'cd to last '$i' visited directory\'
#    if test (count $fishbowl_dir_history) -lt (math '$i' + 1)
#        return 0
#    end
#    cd $fishbowl_dir_history[(math '$i' + 1)]
#end'
#end
