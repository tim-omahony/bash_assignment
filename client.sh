#!/bin/bash

pipe=./$1.pipe
valid_commands=("create add post show shutdown")
trap "rm -f $pipe" EXIT

if [[ ! -p $pipe ]]; then
    mkfifo $pipe
fi

if [ $# -lt 2 ]; then
    echo "Error: parameters problem"
    exit 1
fi
if [[ " ${valid_commands[@]} " =~ " ${2} " ]]; then
    echo "${@:1}" > ./server.pipe
    if [[ "${2}" -eq "show" ]]; then
        cat $pipe
        exit 0
    fi
    while true; do
        while read request_string <$pipe; do
            if [ "$request_string" ] || [ "$request_string" -eq "post" ]; then
                echo $request_string
            else
                exit 0
            fi
        done <$pipe
    done
else
    echo "Error: Invalid command"
fi
