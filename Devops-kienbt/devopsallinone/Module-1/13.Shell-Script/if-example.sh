#!/bin/bash

echo -n Your AGE:
read AGE

if ! [ $AGE -gt 10 ]; then
    echo "Your age is enough"
else
    echo "Sorry your age is'nt enough"
fi
