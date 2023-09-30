#!/bin/bash


# example function with arguments

addition () {
    local FIRST=$1
    local SECOND=$2
    let RESULT=FIRST+SECOND
    echo "Result is : $RESULT"
    let FIRST++
    let SECOND++
}

# do the addition of two numbers
echo -n "Enter your fist number: "
read FIRST

echo -n "Enter your second number: "
read SECOND

addition $FIRST $SECOND

echo "Printing variables"
echo "FIRST: $FIRST"
echo "SECOND: $SECOND"

echo "RESULT: $RESULT"
