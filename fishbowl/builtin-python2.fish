# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license

# 由于目前 Python 相关工作不在基于 Python 2，因此不再使用 Homebrew 安装 Python 2 了
# 但仍有一些包如 Pygments、Fabric 等（主要是当做命令行工具使用）是基于 Python 2 的，
# 结合 OS X 内建的 Python 和 easy_install 命令，并安装到 ~/.local 目录中

set -g -x PYTHONUSERBASE "$HOME/.local"

# ~/.pydistutils.cfg
begin
  set -l config_file "$HOME/.pydistutils.cfg"
  if begin not test -e $config_file; or not test -s $config_file; end
    echo '
[easy_install]
user = 1
zip-ok = 0
index-url = http://pypi.douban.com/simple/
' > $config_file
  end
end
