# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license

# cd shourtcuts
abbr -a -- - 'cd -'
abbr -a -- ... 'cd ../../'
abbr -a -- .... 'cd ../../../'
abbr -a -- ..... 'cd ../../../../'
abbr -a -- ...... 'cd ../../../../../'


set -U fishbowl_dirs_size 500

if not set -qU fishbowl_dirs
    set -U fishbowl_dirs $PWD
end


function _on_pwd_changed --on-variable PWD --description='on the current working directory changed'
    set -U fishbowl_dirs $PWD $fishbowl_dirs
    set -q fishbowl_dirs[$fishbowl_dirs_size] and set -e fishbowl_dirs[1]
end


# call _on_pwd_changed when fish loaded
_on_pwd_changed


function __invoke_directories
    eval "$FISHBOWL_BASEDIR/directories.py $fishbowl_dirs"
    return $status
end


function directories --description='directories'
    set -l tmp (__invoke_directories)
    if test -n $tmp
        echo $tmp
        cd $tmp
    end
end

abbr -a -- d 'directories'



#function d --description='list recently visited directories'
#    set -l num (count $fishbowl_dir_history)
#    set -l realhome ~
#    set -l tmp
#    if test $num -gt 1
#        set -l index (math $num - 1)
#        for item in $fishbowl_dir_history[-1..2]
#        echo -n '  '
#        set_color green; echo -n $index; echo -n ': '; set_color normal
#        echo $item | sed -e "s|^$realhome|~|" $tmp
#        set index (math $index - 1)
#        end
#    end
#    set_color green; echo -n 'PWD: '; set_color normal
#    echo $fishbowl_dir_history[1] | sed -e "s|^$realhome|~|" $tmp
#end


#for i in (seq 1 9)
#    eval 'function $i --description=\'cd to last '$i' visited directory\'
#    if test (count $fishbowl_dir_history) -lt (math '$i' + 1)
#        return 0
#    end
#    cd $fishbowl_dir_history[(math '$i' + 1)]
#end'
#end
