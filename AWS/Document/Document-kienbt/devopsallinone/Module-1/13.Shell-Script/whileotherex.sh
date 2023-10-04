#!/bin/bash


# create script for printing files . which will display also line numbers

# check arguments

if [ $# -ne 1 ]; then
    echo "Please input exactly one argument for this case, run: $0 file-path "
    exit 1
fi

#check if provided argument is a file
if ! [ -f "$1" ]; then
    echo "File you have specified does not exist"
    exit 2
fi

FILENAME=$1
COUNT=1

while read line ; do
    echo "$COUNT: $line"
    let COUNT++
done < "$FILENAME"
