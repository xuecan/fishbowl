# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license


# 浏览器
if test (uname) = 'Darwin'
  set -g -x BROWSER 'open'
end


# 编辑器
if test -n "$SSH_CONNECTION"
  set -g -x EDITOR 'nano'
  set -g -x VISUAL 'nano'
else
  set -g -x EDITOR 'code'
  set -g -x VISUAL 'code'
end


# 分页器
set -g -x PAGER 'less'


# 默认使用 en_US.UTF-8 能够避免很多问题
#if test -z "$LANG"
  set -g -x LANG 'en_US.UTF-8'
#end


# PATH 环境变量
set -g -x PATH /usr/local/bin /usr/bin /bin /usr/local/sbin /usr/sbin /sbin $PATH
if test -d "$HOME/Library/Python/2.7/bin"
  set -g -x PATH $HOME/Library/Python/2.7/bin $PATH
end
if test -d "$HOME/Library/Python/3.5/bin"
  set -g -x PATH "$HOME/Library/Python/3.5/bin" $PATH
end
if test -d "$HOME/.local/bin"
  set -g -x PATH $HOME/.local/bin $PATH
end
if test -d "$HOME/.composer/vendor/bin"
  set -g -x PATH $HOME/.composer/vendor/bin $PATH
end
set -g -x PATH (listutil rmdup $PATH)


# extra modules
fishbowl_load_module python
fishbowl_load_module brewed-node
fishbowl_load_module greeting
fishbowl_load_module prompt
