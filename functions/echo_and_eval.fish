# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license

function echo_and_eval --description='echo a command line then eval it'

  echo -n '> '; set_color cyan; echo $argv; set_color normal
  eval $argv
  return $status

end
