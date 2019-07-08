# Copyright (C) 2019 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license

# enable direnv
begin
    if type -p direnv > /dev/null
        eval (direnv hook fish)
    end
end
