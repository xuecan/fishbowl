# Copyright (C) 2019 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license

# a global but not universal session id
if test -z "$CLOWNFISH_SESSION_ID"
    set -g -x CLOWNFISH_SESSION_ID (uuidgen)
end

# the `clownfish' directory
set -g -x CLOWNFISH_DIR (/usr/bin/dirname (status -f))

# reload main `config.fish`
function reload_config --description='reload main `config.fish`'
    set -l filename $HOME/.config/fish/config.fish
    source $filename
    printf '"%s" reloaded.\n' $filename
end

# load clownfish module
function clownfish_load_module --description='load clownfish module'
    for modulename in $argv
        set -l filename "$CLOWNFISH_DIR/$modulename.fish"
        source $filename
    end
end

# load basic functions
clownfish_load_module _basic_functions

# using `en_US.UTF-8` as default locale can avoid many problems
set -g -x LANG 'en_US.UTF-8'
set -g -x LC_CTYPE 'en_US.UTF-8'

# browser
if test (/usr/bin/uname) = 'Darwin'
    set -g -x BROWSER 'open'
end

# editor
if test -n "$SSH_CONNECTION"
    set -g -x EDITOR 'nano'
    set -g -x VISUAL 'nano'
else
    set -g -x EDITOR 'code'
    set -g -x VISUAL 'code'
end

# modify $PATH according to ~/.path.conf
clownfish_load_module _load_path_conf
