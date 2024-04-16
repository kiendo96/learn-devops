#!/bin/bash

# turn on debug mode in shell script

#set -x

# Turn off debug mode in shell script
# set +x


# Check file if it is regular file and writeable 

echo "Input name of file you wanna check: "
read FILE

if [ -r $FILE ]; then
    echo "Your file is readable"
    ls -la $FILE
else
    ls -la $FILE 
    echo "Your file is not readable file"
    echo "Add read permission for that $FILE"
    chmod +r $FILE
    ls -la $FILE
fi
