#!/bin/bash


# example count with while

A=1
LIMIT=10

while [ "$A" -le "$LIMIT" ]; do
    echo "Create file with name $A"
    touch $A
    let A++
done

