#!/bin/bash

#set -x

# Check file if it is regular file

echo "Input name of file you wanna check: "
read FILE

if [ -d $FILE ]; then
    echo "Your is directory"
    ls -la $FILE
else
    file $FILE
    echo "Your file is not directory"
fi
