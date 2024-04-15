#!/bin/bash

# write script which will work with parameters:
# -f or --file will provide infor about number of lines, words, characters
# -h or --help with provide usage message

while [ "$#" -gt 0 ]; do
    case "$1" in
        -h|--help )
            echo "USAGE: $0 [-h] [--help] [-f file] [--file file]"
            shift # throw away paramater
            exit 1
            ;;
        -f|--file )
            FILE=$2
            if ! [ -f "$FILE" ]; then
                echo "File does not exist"
                exit 2
            fi

            LINES=`cat "$FILE" | wc -l`
            WORD=`cat "$FILE" | wc -w`
            CHARACTERS=`cat "$FILE" | wc -m`

            echo "==FILE: $FILE=="
            echo "Line: $LINES"
            echo "Words: $WORD"
            echo "Characters: $CHARACTERS"
            shift
            shift
            ;;
        * )
            echo "USAGE: $0 [-h] [--help] [-f file] [--file file]"
            exit 1
            ;;
    esac
done
