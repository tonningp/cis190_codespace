#!/bin/bash

echo "Demonstrate decision-making with an if-else statement in a shell script."

echo 'Creating a file named "example.txt"'
touch example.txt

echo 'Checking if "example.txt" exists:'
if [ -f "example.txt" ]; then
    echo '"example.txt" exists.'
else
    echo '"example.txt" does not exist.'
fi

echo "Demonstrate a simple loop with a for loop in a shell script."

echo 'Creating three sample files: file1.txt, file2.txt, file3.txt'
touch file1.txt file2.txt file3.txt

echo 'Using a for loop to list these files:'
for file in file1.txt file2.txt file3.txt; do
    echo "File: $file"
done

echo "Demonstrate creating a simple function in a shell script."

echo 'Defining a function to greet the user:'
greet_user() {
    echo "Hello, welcome to the shell scripting tutorial!"
}

echo 'Calling the greet_user function:'
greet_user

exec bash --rcfile $RCFILE
