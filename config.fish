# Copyright (C) 2019 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license

# bootstrap the `clownfish`
source $HOME/.config/fish/clownfish/bootstrap.fish


# modules
clownfish_load_module pager
clownfish_load_module autojump
clownfish_load_module z
clownfish_load_module direnv
clownfish_load_module dir_aliases

clownfish_load_module greeting
clownfish_load_module prompt
