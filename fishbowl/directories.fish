# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license

# shourtcuts for (../)*
abbr -a ...="../../"
abbr -a ....="../../../"
abbr -a .....="../../../../"
abbr -a ......="../../../../../"


function _on_pwd_changed --on-variable PWD --description='on the current working directory changed'
  set -l tmp_list $fishbowl_dir_history
  if contains -- $PWD $fishbowl_dir_history
    set tmp_list (listutil rm $PWD $tmp_list)
  end
  set tmp_list $PWD $tmp_list
  set -g fishbowl_dir_history (listutil --limit 10 sliced $tmp_list)
end


function d --description='list recently visited directories'
  set -l num (count $fishbowl_dir_history)
  if test $num -lt 2
    return 0
  end
  set -l tmp
  set -l realhome ~
  set -l index (math $num - 1)
  for item in $fishbowl_dir_history[-1..2]
    echo -n '  '
    set_color green; echo -n $index; echo -n ': '; set_color normal
    echo $item | sed -e "s|^$realhome|~|"
    set index (math $index - 1)
  end
  set_color green; echo -n 'PWD: '; set_color normal
  echo $fishbowl_dir_history[1] | sed -e "s|^$realhome|~|"
end


for i in (seq 1 9)
  eval 'function $i --description=\'cd to last '$i' visited directory\'
    if test (count $fishbowl_dir_history) -lt (math '$i' + 1)
      return 0
    end
    cd $fishbowl_dir_history[(math '$i' + 1)]
  end'
end


# call _on_pwd_changed when fish loaded
_on_pwd_changed
