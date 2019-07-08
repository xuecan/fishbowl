# Copyright (C) 2019 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license

# loading hook file of autojump
# TODO: make hook file configurable
begin
    set -l HOOK_FILE /usr/local/share/autojump/autojump.fish
    if test -f "$HOOK_FILE"
        source "$HOOK_FILE"
    end
end
