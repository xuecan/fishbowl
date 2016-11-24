# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license

# 维护 ~/.pip/pip.conf 配置，使用豆瓣的 PyPI 镜像
begin
    if not test -e "$HOME/.pip"
        mkdir "$HOME/.pip"
    end
    set -l config_file "$HOME/.pip/pip.conf"
    echo '
# 请不要直接编辑本文件，fishbowl 将帮助您维护
# 如需修改，请调整 ~/.config/fish/fishbowl/python.fish 脚本

[global]
index-url = https://pypi.douban.com/simple/

' > $config_file
end


# virtual environments base directory
set -g fishbowl_pyvenv_dir "$HOME/.venv"


# venv 命令，用于快速的进入 python virtualenv 环境
# 如果指定的 virtualenv 不存在（不在 ~/.venv 中），则创建之
# 如果需要使用更多的 virtualenv 参数，如使用 -p 指定另外的 python 实例，
# 则需要自行调用 virtualenv 命令，并确保创建的 virtualenv 在 ~/.venv 目录中，
# 后续才能使用这个命令快速进入
function venv --description='Create or enter a Python virtual environment'
    if not count $argv >/dev/null
        echo 'Usage:'
        echo '  venv <python-venv-name>'
        return 0
    end

    if test -n "$VIRTUAL_ENV"
        echo -n 'In virtual environment '
        set_color green; echo -n (basename $VIRTUAL_ENV); set_color normal
        echo -n ', please '
        set_color green; echo -n 'deactivate'; set_color normal;
        echo ' first.'
        return 0
    end

    set -l name $argv[1]
    set -l dir "$fishbowl_pyvenv_dir/$name"
    if test -d $dir
        source "$dir/bin/activate.fish"
    else
        set_color -o yellow
        echo "Virtual environment '$name' not found, creating..."
        set_color red
        echo "You have about 5 seconds to press Ctrl-C to abort."
        set_color normal
        sleep 5
        echo-and-eval virtualenv $dir
        source "$dir/bin/activate.fish"
    end
end
