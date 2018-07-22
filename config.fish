# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license


# a global but not universal session id
if test -z "$FISHBOW_SESSION_ID"
    set -g -x FISHBOW_SESSION_ID (uuidgen)
end


# the `fishbowl' directory
set -g -x FISHBOWL_BASEDIR (dirname (status -f))"/fishbowl"


# reload this config file
function reload-config --description='reload this config file'
    set -l filename (status filename)
    source $filename
    printf '"%s" reloaded.\n' $filename
end


# load fishbowl module
function fishbowl-load-module --description='load fishbowl module'
    for modulename in $argv
        set -l filename "$FISHBOWL_BASEDIR/$modulename.fish"
        source $filename
    end
end


# default modules
fishbowl-load-module basic-functions
fishbowl-load-module pager directories


# load profile.fish
set -g _fishbowl_not_trace_dir 'yes'
source "$FISHBOWL_BASEDIR/../profile.fish"
set -g -e _fishbowl_not_trace_dir
