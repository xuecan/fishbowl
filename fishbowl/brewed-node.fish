# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license

# 使用 Homebrew 安装 node.js，并使用淘宝提供的镜像（通过 cnpm 命令）
# 还会在全局安装几个常用的包
function reinstall-node --description='reinstall brewed node6-lts'
  set -l brewed_packages (brew list)
  if contains node6-lts $brewed_packages
    echo-and-eval cnpm uninstall -g express-generator
    echo-and-eval cnpm uninstall -g gulp-cli
    echo-and-eval cnpm uninstall -g bower
    echo-and-eval cnpm uninstall -g node-gyp
    echo-and-eval npm uninstall -g cnpm
    echo-and-eval brew uninstall node6-lts
  end
  echo-and-eval brew install node6-lts
  echo-and-eval npm install -g cnpm --registry=https://registry.npm.taobao.org
  echo-and-eval cnpm install -g node-gyp
  echo-and-eval cnpm install -g bower
  echo-and-eval cnpm install -g gulp-cli
  echo-and-eval cnpm install -g express-generator
end
