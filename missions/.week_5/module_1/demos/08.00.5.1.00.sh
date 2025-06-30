#!/bin/bash

echo "Demonstrate brace expansion to create a list of files."
echo "touch file{1..3}.txt"
echo "ls file*.txt"

echo "Demonstrate tilde expansion to move to the home directory."
echo "cd ~"
echo "pwd"

echo "Demonstrate parameter expansion to display a variable's value."
echo "my_var='drone_info'"
echo 'echo "The value of my_var is: $my_var"'

echo "Demonstrate using special characters like '*' to list all text files."
echo "ls *.txt"

exec bash --rcfile $RCFILE
