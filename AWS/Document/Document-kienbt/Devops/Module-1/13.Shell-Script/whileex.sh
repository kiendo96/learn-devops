#!/bin/bash


# example while loop


echo -p "Please input your name: "
read NAME

while [ "$NAME" != "KIEN" ]; do
    echo "You name is $NAME"
    exit 1
done

