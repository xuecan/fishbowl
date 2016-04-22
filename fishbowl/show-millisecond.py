#!/usr/bin/python2.7
# -*- coding: UTF-8 -*-
# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license

import sys


def convert(value):
    if value < 1000:
        return '%dms' % value
    ms = value % 1000
    value = value / 1000
    if value < 60:
        return '%d.%03ds' % (value, ms)
    sec = value % 60
    value = value / 60
    if value < 60:
        return '%dm%ds' % (value, sec)
    minute = value % 60
    value = value / 60
    return '%dh%dm%ds' % (value, minute, sec)


def main(value):
    value = int(value)
    print convert(value)


if __name__ == '__main__':
    main(sys.argv[1])
