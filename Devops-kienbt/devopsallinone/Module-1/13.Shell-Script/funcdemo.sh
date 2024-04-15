#!/bin/bash


# example fuc

echo "Welcome to my script $0"
# this function for display name user to screen
display_name () {

    echo "My name is Kien"
}

# this function for display age user to screen
function display_age {
    echo "You age is 30"
}

# run code in function
display_name

# run code in function
display_age
