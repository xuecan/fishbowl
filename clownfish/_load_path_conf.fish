# Copyright (C) 2019 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license

# load paths from ~/.path.conf
begin
    set -l CONFIG_FILE $HOME/.path.conf
    if test -f "$CONFIG_FILE"
        set PATH (/usr/bin/sed \
                    -e '/^#/'d \
                    -e '/^$/'d \
                    -e 's#^~#'$HOME'#'g \
                    "$CONFIG_FILE") $PATH
    end
    set -l tmp_list
    for item in $PATH
        if not contains $item $tmp_list
            set tmp_list $tmp_list $item
        end
    end
    set PATH $tmp_list
end
