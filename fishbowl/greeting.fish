# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license

function fish_greeting
    printf '\n'
    printf '║ '(set_color -u)(set_color -o d75f00)'f'(set_color -o ffff00)'i'(set_color -o ff0000)'sh'(set_color normal)' shell --'
    printf ' the '(set_color -o d75f00)'F'(set_color normal)'riendly'
    printf ' '(set_color -o ffff00)'I'(set_color normal)'nteractive'
    printf ' '(set_color -o ff0000)'Sh'(set_color normal)'ell,'
    printf ' version '(set_color -u 5fffff)'%s'(set_color normal)'.\n' $version
    printf '║ Type '(set_color -o green)'help'(set_color normal)' for help documentation. '
    printf 'Type '(set_color -o green)'fish_config'(set_color normal)' to start the\n'
    printf '║ web-based configuration interface. For more information about\n'
    printf '║ the '(set_color -u 5fffff)'fishbowl'(set_color normal)' project'
    printf ', check the '(set_color -u green)'~/.config/fish/config.fish'(set_color normal)' script.\n'
    printf '\n'
end
