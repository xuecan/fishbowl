# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license


# browser
if test (uname) = 'Darwin'
  set -g -x BROWSER 'open'
end


# editor
if test -n "$SSH_CONNECTION"
  set -g -x EDITOR 'nano'
  set -g -x VISUAL 'nano'
else
  set -g -x EDITOR 'atom'
  set -g -x VISUAL 'atom'
end


# pager
set -g -x PAGER 'less'


# language
#if test -z "$LANG"
  set -g -x LANG 'en_US.UTF-8'
#end


# paths
set -g -x PATH ~/.local/bin /usr/local/bin /usr/bin /bin /usr/local/sbin /usr/sbin /sbin $PATH
set -g -x PATH (listutil rmdup $PATH)


# fishbowl modules want to load
set -g fishbowl_modules pager terminal dots \
                        builtin-python2 \
                        brewed-python3 \
                        brewed-node
