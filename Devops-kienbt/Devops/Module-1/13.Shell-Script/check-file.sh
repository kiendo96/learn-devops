#!/bin/bash

#echo "Check if file existing"

FILE=file2

if [ -e $FILE ]; then
    ls -la $FILE
else
    echo "File is not existing"
fi
