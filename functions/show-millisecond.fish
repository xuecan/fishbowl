# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license


function show-millisecond -d "invoke `show-millisecond.py'"
  eval "$fishbowl_basedir/fishbowl/show-millisecond.py $argv"
  return $status
end
