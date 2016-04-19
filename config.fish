# Copyright (C) 2016 Xue Can <xuecan@gmail.com> and contributors.
# Licensed under the MIT license: http://opensource.org/licenses/mit-license

# this directory
set -g fishbowl_basedir (dirname (status -f))

# reload this config file
function reload-config --description='reload this config file'
  set -l filename (status -f)
  source $filename
  echo '"'$filename'" reloaded.'
end

# load fishbowl module
function fishbowl_load_module --description='load fishbowl module'
  for modulename in $argv
    set -l filename "$fishbowl_basedir/fishbowl/$modulename.fish"
    source $filename
  end
end

# load profile.fish
source "$fishbowl_basedir/profile.fish"

# load modules
for modulename in $fishbowl_modules
  fishbowl_load_module $modulename
end
