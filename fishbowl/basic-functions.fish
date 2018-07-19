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
