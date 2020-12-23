#!/bin/bash
arguments=($@)
printf -v lockfile_name "%s_" "${arguments[@]}"
lockfile_name=${lockfile_name%?}
if { set -C; 2>/dev/null >./$lockfile_name.lock; }; then
    trap "rm -f ./$lockfile_name.lock" EXIT
else
    echo "Lock file exists… exiting"
    exit
fi
if [ "$#" -eq 0 ] || [ "$#" -gt 1 ]; then
    echo "Error: parameter problem"
    exit 1
    elif [ -d "$@" ]; then
        echo "Error: user already exists"
        exit 1
    else
        mkdir "$@"
        touch "$@/wall"
        touch "$@/friends"
        echo "OK: user created"
        exit 0
fi
