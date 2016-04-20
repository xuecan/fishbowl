# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license


# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
set -g -x LESS '-F -g -i -M -R -S -w -X -z-4'


# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
begin
  set -l lesspipe (command -s lesspipe; or command -s lesspipe.sh)
  if test -n $lesspipe
    set -g -x LESSOPEN "| $lesspipe %s"
  end
end


# Set the Less colorizer.
begin
  set -l pygmentize (command -s pygmentize)
  set -g -x LESSCOLORIZER 'pygmentize'
end


# Make man colorful.
# http://unix.stackexchange.com/questions/108699/documentation-on-less-termcap-variables
set -g -x LESS_TERMCAP_mb \e'[01;31m'      # Begins blinking.
set -g -x LESS_TERMCAP_md \e'[01;34m'      # Begins bold.
set -g -x LESS_TERMCAP_me \e'[0m'          # Ends mode.
set -g -x LESS_TERMCAP_se \e'[0m'          # Ends standout-mode.
set -g -x LESS_TERMCAP_so \e'[00;47;30m'   # Begins standout-mode.
set -g -x LESS_TERMCAP_ue \e'[0m'          # Ends underline.
set -g -x LESS_TERMCAP_us \e'[01;04;32m'   # Begins underline.
