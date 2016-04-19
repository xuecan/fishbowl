#!/usr/bin/python2.7
# -*- coding: UTF-8 -*-
# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license


"""fishbowl list utilities"""

__version__ = '1.0.1'


import sys
import click


SETTINGS = {
    'LIMIT': 0,
    'OFFSET': 1,
    'REVERSE': False,
}


def _slice(items):
    begin = max(0, SETTINGS['OFFSET'] - 1)
    count = max(0, SETTINGS['LIMIT'])
    if not count:
        end = len(items)
    else:
        end = begin + count
    return items[begin:end]


def _echo(items):
    for item in items:
        print(item)


@click.group(context_settings=dict(help_option_names=['-h', '--help']))
@click.option('--limit', '-l', default=0, help='Limit tems count.')
@click.option('--offset', '-o', default=1, help='Offset of items, starts at 1.')
@click.option('--reverse', '-r', is_flag=True, help='Reverses items.')
def main(**kwargs):
    for key in kwargs:
        setting_key = key.replace('_', '-').upper()
        assert setting_key in SETTINGS, 'Oops'
        SETTINGS[setting_key] = kwargs[key]


@main.command()
@click.argument('items', nargs=-1)
def rmdup(items):
    """Removes duplicated values in ITEMS."""
    result = list()
    for item in items:
        if item not in result:
            result.append(item)
    _echo(_slice(result))


@main.command()
@click.argument('value', nargs=1)
@click.argument('items', nargs=-1)
def rm(value, items):
    """Remove the given VALUE in ITEMS."""
    result = list()
    for item in items:
        if item != value:
            result.append(item)
    _echo(_slice(result))


@main.command()
@click.option('--type', '-t', default='str',
              type=click.Choice(['num', 'str']),
              help='Data type of items.')
@click.argument('items', nargs=-1)
def sort(type, items):
    """Sort ITEMS."""
    try:
        if type == 'num':
            from decimal import Decimal
            result = [Decimal(item) for item in items]
        else:
            result = list(items)
    except Exception as err:
        sys.stderr.write(err.args[0])
        sys.exit(2)
    result.sort()
    _echo(_slice(result))


@main.command()
@click.argument('items', nargs=-1)
def sliced(items):
    """slice ITEMS"""
    result = list(items)
    _echo(_slice(result))


if __name__ == '__main__':
    main()
