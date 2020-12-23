#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Error: parameters problem"
    exit 1
elif [ ! -d "$1" ]; then
    echo "Error: user does not exist"
    exit 1
else
    cat $1/wall > $2.pipe
    exit 0
fi
