#!/usr/bin/python2.7
# -*- coding: UTF-8 -*-
# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license

from __future__ import print_function
import sys


def convert(value):
    """Convert value in milliseconds to a string."""
    milliseconds = value % 1000
    value = value // 1000
    seconds = value % 60
    value = value // 60
    minutes = value % 60
    value = value // 60
    hours = value % 24
    value = value // 24
    days = value
    if days:
        result = "%dd%dh%dm" % (days, hours, minutes)
    elif hours:
        result = "%dh%dm%ds" % (hours, minutes, seconds)
    elif minutes:
        result = "%dm%ds" % (minutes, seconds)
    else:
        result = "%d.%03d" % (seconds, milliseconds)

    return result


if __name__ == "__main__":
    print(convert(int(sys.argv[1])))
