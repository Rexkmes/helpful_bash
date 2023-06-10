#!/bin/bash

# the number of parallel processes
parallel_processes=10

# the list
parameter_names=($(cat /usr/share/seclists/Discovery/Web-Content/raft-medium-words.txt))

send_request() {
    local parameter_name="$1"

    response=$(curl -s -X POST 'http://trilor.local/support/add' \
        -d '{"'"$parameter_name"'":"aaa"}' #parameter_name where the fuzz happens \
        -b "PHPSESSID=b7f1ucc4q4bb17lo0l5jrlifaa" #cookie if needed \
        -H 'Content-Type: application/json')
#to get only different response 
    if [[ $response != *"Missing parameter ticket."* ]]; then
        echo "Parameter: $parameter_name"
        echo "Response: $response"
        echo "------------------------"
    fi
}

export -f send_request

printf "%s\n" "${parameter_names[@]}" | xargs -P "$parallel_processes" -I {} bash -c 'send_request "$@"' _ {}
