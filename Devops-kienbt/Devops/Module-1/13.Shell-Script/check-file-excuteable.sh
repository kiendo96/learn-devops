#!/bin/bash

#set -x

# Check file if it is regular file and executeable

echo "Input name of file you wanna check: "
read FILE

if [ -x $FILE ]; then
    echo "Your file is executeable file"
    ls -la $FILE
else
    ls -la $FILE
    chmod +x $FILE
    echo "Your file is not executeable"
fi
