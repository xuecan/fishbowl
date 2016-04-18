# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license


function listutil -d "invoke `listutil.py'"
  eval "$fishbowl_basedir/fishbowl/listutil.py $argv"
  return $status
end
