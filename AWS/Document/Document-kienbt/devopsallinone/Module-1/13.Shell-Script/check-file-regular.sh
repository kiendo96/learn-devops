#!/bin/bash

#set -x

# Check file if it is regular file

echo "Input name of file you wanna check: "
read FILE

if [ -f $FILE ]; then
    echo "Your is regular file"
    chmod 777 $FILE
    ls -la $FILE
else
    file $FILE
    echo "Your file is not regular file"
fi
