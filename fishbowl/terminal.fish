# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license


if status -i

  # https://fishshell.com/docs/current/index.html#title
  function fish_title --description 'set the message displayed in the titlebar of the terminal window'
    if test $_ != 'fish'
      echo $_ ' '
    end
    prompt_pwd
  end

end
