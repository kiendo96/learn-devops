#!/bin/bash


# example array
# List all file with .sh extention

ARRAY=($(ls *.sh))
COUNT=0
echo -e "FILE NAME \t WRITEABLE"; d


for FILE in "${ARRAY[@]}"; do
    echo -n $FILE
    echo -n "[${#ARRAY[$COUNT]}]"
    if [ -x "$FILE" ]; then
        echo -e "\t YES"
    else
        echo -e "\t NO"
    fi
    let COUNT++
done
