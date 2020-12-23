#!/bin/bash

if { set -C; 2>/dev/null >./$1.lock;  }; then
    trap "rm -f ./$1.lock" EXIT
else
    echo "Lock file exists… exiting"
    exit 1
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
