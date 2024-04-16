#!/bin/bash

#set -x

# Check file if it is regular file

echo "Input name of file you wanna check: "
read FILE

if [ -w $FILE ] && [ -r $FILE ]; then
    echo "Your file is okay with both of permission"
    ls -la $FILE
else
     ls -la $FILE
    echo "Your file is not with full read write permission"
    echo =================0==============================
    echo "Let me add read write permission to your file"
    chmod +rw $FILE
    ls -la $FILE
fi
