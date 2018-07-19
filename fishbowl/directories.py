#!/usr/bin/python2.7
# -*- coding: UTF-8 -*-
# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license

from __future__ import print_function, unicode_literals

"""fishbowl dir history utilities"""

__version__ = '0.9.0'

import os
import sys

from click import echo, style, getchar


CHARS = '0123456789abcdefghijklmnopqrstuvwxyz'
HOME = os.path.expanduser('~')
PWD = os.getcwd()


def shorten(name):
    if name == HOME:
        return "~"
    if name.startswith(HOME + os.path.sep):
        return "~" + name.replace(HOME, "", 1)
    return name


def unshorten(name):
    if name.startswith("~"):
        return name.replace("~", HOME, 1)
    return name


def write_line(key, name):
    echo("[" + style(key, fg="green") + "] " + name, err=True)


def choose():
    dirs = sys.argv[1:]
    counters = dict()
    for name in dirs:
        name = shorten(name)
        if name in counters:
            counters[name] += 1
        else:
            counters[name] = 1
    if HOME == PWD:
        write_line(" ", PWD)
    else:
        write_line("~", HOME)
        write_line(" ", PWD)
    echo(err=True)
    items = sorted(counters, reverse=True)
    index = 0
    for item in items:
        index += 1
        if index > 35:
            break
        write_line(CHARS[index], item)
    echo(err=True)
    echo("Select a directory: ", nl=False, err=True)
    c = getchar()
    #echo(err=True)
    if c in ('-', '=', '_'):
        return "-"
    if c in ('~', '`'):
        return HOME
    if c in CHARS:
        index = CHARS.index(c) - 1
        if index >= 0 and index < len(items):
            return unshorten(items[index])


def main():
    result = choose()
    if result and result != PWD:
        print(result)


if __name__ == '__main__':
    main()
