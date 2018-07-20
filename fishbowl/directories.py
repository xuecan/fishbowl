#!/usr/bin/python2.7
# -*- coding: UTF-8 -*-
# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license

from __future__ import print_function

"""fishbowl dir history utilities"""

__version__ = '0.9.0'

import os
import sys
import time
import marshal

from os import path
from click import echo, style, getchar, get_app_dir, command, argument


NOW = time.time()
PWD = os.getcwd()
HOME = os.path.expanduser('~')
CHARS = "0123456789abcdefghijklmnopqrstuvwxyz"
APP_DIR = get_app_dir('fishbowl', force_posix=True)
DATA_FILE = path.join(APP_DIR, "data")

CONF = {
    "LEVELS": [
        (1, 1.0),
        (3, 0.8),
        (7, 0.5),
        (30, 0.3),
        (90, 0.2),
        (365, 0.1)
    ],
    "ITEMS": 10000,
}


if not path.exists(APP_DIR):
    os.makedirs(APP_DIR)


def _shorten_dirname(name):
    if name == HOME:
        return "~"
    if name.startswith(HOME + os.path.sep):
        return "~" + name.replace(HOME, "", 1)
    return name


def _unshorten_dirname(name):
    if name.startswith("~"):
        return name.replace("~", HOME, 1)
    return name


def _load_data():
    try:
        with open(DATA_FILE, "rb") as fp:
            data = marshal.load(fp)
        assert isinstance(data, list), "Oops! Dumped data is not a list."
    except IOError as err:
        if err.args[0] == 2:
            # [Errno 2] No such file or directory
            data = list()
        else:
            raise
    items = list()
    max_lifetime = CONF["LEVELS"][-1][0] * 86400
    counter = 0
    while data:
        counter += 1
        if counter >= CONF["ITEMS"]:
            break
        item = data.pop(0)
        if item[0] + max_lifetime >= NOW:
            items.insert(0, item)
        else:
            break
    return items


def _save_data(data):
    with open(DATA_FILE, "wb") as fp:
        data = marshal.dump(data, fp)


def remember(directory):
    assert path.isabs(directory), "Oops! Not an absolute path."
    assert path.isdir(directory), "Oops! Not a directory."
    data = _load_data()
    if data and data[0][1] == directory:
        return
    item = (NOW, directory)
    data.insert(0, item)
    _save_data(data)


def clear_data():
    try:
        os.unlink(DATA_FILE)
    except OSError:
        pass


def _key_func(num):
    if num > 0:
        return 1
    if num < 0:
        return -1
    return 0


def _calc_weight(data):
    registry = dict()
    for item in data:
        timestamp, dirname = item
        if not path.exists(dirname):
            continue
        weight = 0
        for level in CONF["LEVELS"]:
            if timestamp > (NOW - level[0] * 86400):
                weight = level[1]
                break
        if dirname in registry:
            registry[dirname] += weight
        else:
            registry[dirname] = weight
    result = sorted(registry,
                    lambda x, y: _key_func(registry[x] - registry[y]),
                    reverse=True)
    return result


def _show_item(dirname=None, key=" ", role=None):
    if not dirname:
        echo(err=True)
        return
    part1 = style(key, fg="green", bold=True)
    if key == "~":
        part2 = style(dirname, fg="green")
    elif key == " ":
        part2 = style(_shorten_dirname(dirname), fg="yellow", bold=True)
    else:
        part2 = style(_shorten_dirname(dirname))
    echo("[%s] %s" % (part1, part2), err=True)


def _show_items(items):
    _show_item(HOME, "~")
    _show_item(PWD, " ")
    _show_item()
    index = 0
    for item in items:
        _show_item(item, CHARS[index])
        index += 1
        if index > 35:
            break
    _show_item()


def _get_prompt():
    echo("Select a directory: ", nl=False, err=True)
    return getchar()


def _output_selected(items, ch):
    if ch in ('-', '=', '_'):
        return "-"
    if ch in ('~', '`'):
        return HOME
    if ch in CHARS:
        index = CHARS.index(ch)
        if index >= 0 and index < len(items):
            return _unshorten_dirname(items[index])


def select_directory():
    data = _load_data()
    items = _calc_weight(data)
    _show_items(items)
    ch = _get_prompt()
    echo(style(ch, fg="magenta", bold=True), err=True)
    dirname = _output_selected(items, ch)
    if dirname:
        print(dirname.encode(sys.getfilesystemencoding()))


@command(context_settings=dict(help_option_names=['-h', '--help']))
@argument("directory", default="")
def main(**kwargs):
    "Directories util"
    if kwargs["directory"]:
        directory = kwargs["directory"]
        if directory == "<clear>":
            clear_data()
        else:
            remember(directory)
    else:
        select_directory()


if __name__ == "__main__":
    main()
