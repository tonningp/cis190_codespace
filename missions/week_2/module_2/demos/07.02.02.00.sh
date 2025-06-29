#!/bin/bash

echo "Demonstrate how to create a new directory named 'drone_data'."
echo "Command: mkdir drone_data"
mkdir drone_data

echo "Demonstrate how to change into the 'drone_data' directory."
echo "Command: cd drone_data"
cd drone_data

echo "Demonstrate how to remove an empty directory named 'drone_data'."
echo "Command: cd ..; rmdir drone_data"
cd ..
rmdir drone_data

echo "Demonstrate how to create a non-empty directory and remove it."
echo "Commands:"
echo "mkdir drone_data"
echo "touch drone_data/sample.txt"
echo "rm -r drone_data"
mkdir drone_data
touch drone_data/sample.txt
rm -r drone_data

exec bash --rcfile $RCFILE
