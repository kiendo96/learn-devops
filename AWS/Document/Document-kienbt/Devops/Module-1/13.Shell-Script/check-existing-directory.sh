#!/bin/bash

set -x

# Check file if it is directory


echo "This shell scipt using for check exsiting directory"
FOLDER=$(pwd)


if [ -d $FOLDER ]; then
    echo "Your input is directory"
    file $FOLDER
elif [ "$FOLDER" = "/Users/kienbui/Lession6" ]; then
    echo "You are in right place"
    ls -la $FOLDER
else 
    echo "You are not in right place"
fi
