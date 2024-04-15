#!/bin/bash

echo -n "Please input your string1: "
read STR1
echo -n "Please input your string2: "
read STR2
echo "Compare string"

if [ "$STR1" != "$STR2" ]; then
    echo "The diffirent string"
else
    echo "the same string"
fi
