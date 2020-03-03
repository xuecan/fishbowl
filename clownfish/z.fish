# Copyright (c) 2014 Bruno Ferreira Pinto
# Licensed under the MIT license: http://opensource.org/licenses/mit-license

# Upstream: https://github.com/oh-my-fish/plugin-z


function z -d "jump around"
    # Brewed z.sh
    set -l -x Z_SCRIPT_PATH /usr/local/etc/profile.d/z.sh

    # Start a Bash process, source z, run the _z function, and capture the working directory and exit status.
    bash -c '
        source $Z_SCRIPT_PATH
        _z "$@" 2>&1
        Z_STATUS=$?
        echo "$PWD" >&2
        exit $Z_STATUS
    ' bash $argv 2>| read -l Z_PWD
    set -l Z_STATUS $status

    # If z changed directories, reflect that in the current process.
    if test $Z_PWD != $PWD
        builtin cd $Z_PWD
    end

    return $Z_STATUS
end


function z.pwd --on-variable PWD
    status --is-command-substitution
        and return

    z --add $PWD
end


function z.complete
    z -l $argv | awk '{print $2}'
end

complete -c z -s c -d "Restrict matches to subdirectories of the current directory"
complete -c z -s h -d "Show a brief help message"
complete -c z -s l -d "List only"
complete -c z -s r -d "Match by rank only"
complete -c z -s t -d "Match by recent access only"
complete -c z -s x -d "Remove the current directory from the datafile"

complete -c z --no-files -a '(z.complete)'
