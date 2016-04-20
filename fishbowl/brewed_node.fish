# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license

# 使用 Homebrew 安装 node.js，并使用淘宝提供的镜像（通过 cnpm 命令）

function reinstall-node --description='reinstall brewed node'
  set -l brewed_packages (brew list)
  if contains node $brewed_packages
    echo_and_eval cnpm uninstall -g gulp
    echo_and_eval cnpm uninstall -g bower
    echo_and_eval cnpm uninstall -g node-gyp
    echo_and_eval npm uninstall -g cnpm
    echo_and_eval brew uninstall node
  end
  echo_and_eval brew install node
  echo_and_eval npm install -g cnpm --registry=https://registry.npm.taobao.org
  echo_and_eval cnpm install -g node-gyp
  echo_and_eval cnpm install -g bower
  echo_and_eval cnpm install -g gulp
end