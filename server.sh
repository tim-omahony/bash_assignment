#!/bin/bash

pipe=./server.pipe

trap "rm -f $pipe" EXIT

if [[ ! -p $pipe  ]]; then
    mkfifo $pipe
fi

while true; do
    if read request_string <$pipe; then
    request=($request_string)
        case ${request[1]} in
            create)
                ./create.sh ${request[2]} >${request[0]}.pipe &
                ;;
            add)
                ./add.sh ${request[2]} ${request[3]} >${request[0]}.pipe &
                ;;
            post)
                ./post.sh ${request[2]} ${request[3]} ${request[4]} >${request[0]}.pipe &
                ;;
            show)
                ./show.sh ${request[2]} ${request[0]} > $2.pipe & 
                ;;
            shutdown)
                exit 0
                ;;
            *)
                echo "Error: bad request" >${request[0]}.pipe
                exit 1
        esac
    fi
done
