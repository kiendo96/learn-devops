#!/bin/bash

#example for loop
set -x
# into all .txt files in the current directory and a new line with the current date
# and first 5 lines of ps command

for FILE in *.txt
do
    echo "$(date) >> $FILE"
    ps -ef | head -5 >> $FILE
    echo ================== >> $FILE
done

