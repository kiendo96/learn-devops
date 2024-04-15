#!/bin/bash


# example about exit code

FILENAME="buitrungkien.sh"

cat $FILENAME 2> /dev/null

if [ "$?" -ne 0 ]; then
    echo "$FILENAME does not exist"
    echo "$FILENAME is creating"
    sleep 5
    touch $FILENAME
    ls -la $FILENAME
else
    echo "$FILENAME does exist"
fi


