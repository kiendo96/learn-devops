#!/bin/bash


VAR=5
COUNT=80

if [ $VAR -eq 5 ]; then
    echo "Number equal 5"
fi

if [ $VAR -gt 5 ]; then
    echo "Number greate than 5"
fi

if [ $VAR -eq 5 ] && [ $COUNT -le 100 ]; then
    echo "Statement is true"
fi
