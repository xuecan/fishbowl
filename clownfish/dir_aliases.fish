# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license

function unregister_directory_abbrs --description='unregister directories abbrs'
    abbr -e -- -
    abbr -e -- ...
    abbr -e -- ....
    abbr -e -- .....
    abbr -e -- ......
end

begin
    abbr -a -- - 'cd -'
    abbr -a -- ... 'cd ../../'
    abbr -a -- .... 'cd ../../../'
    abbr -a -- ..... 'cd ../../../../'
    abbr -a -- ...... 'cd ../../../../../'
end
