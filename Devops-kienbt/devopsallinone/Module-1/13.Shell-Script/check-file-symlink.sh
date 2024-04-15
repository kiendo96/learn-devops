#!/bin/bash

#set -x

# Check file if it is syboliclink file

echo "Input name of file you wanna check: "
read FILE

if [ -L $FILE ]; then
    echo "Your file is symlink file"
    ls -la $FILE
else
    file $FILE
    echo "Your file is not symlink file"
fi
