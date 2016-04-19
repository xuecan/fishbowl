# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license

# 由于目前 Python 相关工作主要基于 Python 3，因此使用 Homebrew 安装 Python 3
# 实际工作中，并不使用全局的 python3 环境安装需要的包和/或进行其它工作，代之以使用
# venv 环境，这样重新安装 python3 时无需在 /usr/local/lib 中删除包并重装它们

# virtual environments base directory
set -g fishbowl_pyvenv_dir "$HOME/.venv"


function reinstall-python3 --description='reinstall brewed python3'
  set -l brewed_packages (brew list)
  if contains python3 $brewed_packages
    brew uninstall python3
  end
  brew install python3
end


function pip --description='ensure we are in a virtual environment'
  if test -z "$VIRTUAL_ENV"
    echo 'No virtual environments detected, operation abort.'
    return 1
  else
    command pip $argv
  end
end


# pip3, pip3.5, ... etc
begin
  set -l pip_commands
  for i in (brew --prefix)/bin/pip3*
     set -l tmp (basename $i)
     if not contains $tmp $pip_commands
      set pip_commands $pip_commands $tmp
     end
  end
  for i in $pip_commands
    alias $i pip
  end
end

# ~/.pip/pip.conf
begin
  if not test -e "$HOME/.pip"
    mkdir "$HOME/.pip"
  end
  set -l config_file "$HOME/.pip/pip.conf"
  if begin not test -e $config_file; or not test -s $config_file; end
    echo '
[global]
index-url = http://pypi.douban.com/simple/
trusted-host = pypi.douban.com
' > $config_file
  end
end


function venv --description='create or enter a pyvenv'
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
    echo-and-eval source "$dir/bin/activate.fish"
  else
    set_color -o yellow
    echo "Virtual environment '$name' not found, creating..."
    set_color red
    echo "You have about 5 seconds to press Ctrl-C to abort."
    set_color normal
    sleep 5
    echo-and-eval (brew --prefix)/bin/pyvenv $dir
    echo-and-eval source "$dir/bin/activate.fish"
  end

end
