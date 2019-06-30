# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license


# 默认使用 en_US.UTF-8 能够避免很多问题
#if test -z "$LANG"
    set -g -x LANG 'en_US.UTF-8'
    set -g -x LC_CTYPE 'en_US.UTF-8'
#end


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


# PATH 环境变量
set -g -x PATH /usr/local/bin /usr/bin /bin /usr/local/sbin /usr/sbin /sbin $PATH

#if type -p go > /dev/null
#    set -g -x GOROOT (go env GOROOT)
#    set -g -x PATH $GOROOT/bin $PATH
#end

# 如果使用的是 Keg Only 的 PHP 版本
set -g -x PATH /usr/local/opt/php@7.2/bin /usr/local/opt/php@7.2/sbin $PATH


begin
    # 如果这些路径存在，则**依次**加在 $PATH 最前，因此这个列表越后面的路径将被加在越前面
    set -l extra_paths $HOME/Library/Python/2.7/bin $HOME/Library/Python/3.6/bin $HOME/.local/bin
    for _path in $extra_paths
        if test -d $_path
            set -g -x PATH $_path $PATH
        end
    end
end

# 移除 $PATH 中重复的项
set -g -x PATH (listutil rmdup $PATH)


# fishbowl 提供的额外模块
#fishbowl-load-module python
#fishbowl-load-module brewed-node
fishbowl-load-module greeting
fishbowl-load-module prompt

# 启用 direnv
if type -p direnv > /dev/null
    eval (direnv hook fish)
end

# 使用 brew cask install google-cloud-sdk 安装了 Google Cloud SDK
begin
    set -l filename '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc'
    if test -f $filename
        source $filename
    end
end
