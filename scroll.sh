#!/bin/bash

STRING="what a wonderful world this could be"

function typewriter
{
    text="$1"
    delay="$2"

    for i in $(seq 0 ${#text}) ; do
        echo -n "${text:$i:1}"
        sleep ${delay}
    done
}


typewriter "Typewriters are cool." .015
echo # <-- Just for a newline