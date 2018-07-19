# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license


# session id
if test -z "$fishbow_session_id"
    set -g fishbow_session_id (uuidgen)
end


# this directory
set -g fishbowl_basedir (dirname (status -f))


# reload this config file
function reload-config --description='reload this config file'
    set -l filename (status -f)
    source $filename
    echo '"'$filename'" reloaded.'
end


# load fishbowl module
function fishbowl-load-module --description='load fishbowl module'
    for modulename in $argv
        set -l filename "$fishbowl_basedir/fishbowl/$modulename.fish"
        source $filename
    end
end


# default modules
fishbowl-load-module pager terminal directories


# load profile.fish
source "$fishbowl_basedir/profile.fish"

# The next line updates PATH for the Google Cloud SDK.
#if [ -f '/Users/xuecan/Downloads/google-cloud-sdk/path.fish.inc' ];
#    if type source > /dev/null;
#        source '/Users/xuecan/Downloads/google-cloud-sdk/path.fish.inc';
#    else;
#        . '/Users/xuecan/Downloads/google-cloud-sdk/path.fish.inc';
#    end;
#end
