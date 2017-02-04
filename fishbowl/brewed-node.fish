# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license

# 使用 Homebrew 安装 node.js LTS 版本，并使用淘宝提供的镜像（通过 cnpm 命令）
# 还会在全局安装几个常用的包(可以访问 https://www.npmjs.com/ 了解这些包的用途)
function reinstall-node --description='reinstall brewed node'
    set -l brewed_packages (brew list)
    if contains node $brewed_packages
        echo-and-eval cnpm uninstall -g express-generator
        echo-and-eval cnpm uninstall -g gulp-cli
        echo-and-eval cnpm uninstall -g bower
        echo-and-eval cnpm uninstall -g node-gyp
        echo-and-eval brew uninstall node
    end
    echo-and-eval brew install node@
    echo-and-eval npm install -g node-gyp
    echo-and-eval npm install -g bower
    echo-and-eval npm install -g gulp-cli
    echo-and-eval npm install -g express-generator
end
