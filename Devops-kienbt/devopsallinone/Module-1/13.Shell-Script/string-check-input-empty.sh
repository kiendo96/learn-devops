#!/bin/bash

#Check string input by user

echo -n "Input your name: "
read NAME


if [ -z $NAME ]; then
    echo "You must input some characters"
else
    echo "Your name is : $NAME"
fi

