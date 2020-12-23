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
if [ "$#" -ne 2 ]; then
    echo "Error: parameters problem"
    exit 1
elif [ ! -d "$1" ]; then
    echo "Error: user does not exist"
    exit 1
elif [ ! -d "$2" ]; then
    echo "Error: friend does not exist"
    exit 1
elif grep -q "$2" $1/friends; then
    echo "Error: user already friends with this user"
    exit 1
else
    echo "$2" >> "$1/friends"
    echo "OK: friend added"
    exit 0
fi
