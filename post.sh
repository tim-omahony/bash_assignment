#!/bin/bash

if { set -C; 2>/dev/null >./$1.lock;  }; then
    trap "rm -f ./$1.lock" EXIT
else
    echo "Lock file exists… exiting"
    exit 1
fi
if [ "$#" -ne 3 ]; then
    echo "Error: parameters problem"
    exit 1
elif [ ! -d "$1" ]; then
    echo "Error: Receiver does not exist"
    exit 1
elif [ ! -d "$2" ]; then
    echo "Error: Sender does not exist"
    exit 1
elif ! grep -q "$2" $1/friends; then
    echo "Error: Sender is not a friend of receiver"
    exit 1
else
    echo "$2: ""$3" >> "$1/wall"
    echo "Ok: Message(s) posted to wall"
    exit 0
fi
