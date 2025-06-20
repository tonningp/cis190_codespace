#!/bin/bash

echo "Demonstrate how to use sed to replace words in a file."
echo "Original file content:"
echo "The drone is flying over the testing area." > drone_test.txt
cat drone_test.txt

echo "Using sed to replace 'drone' with 'UAV':"
sed 's/drone/UAV/' drone_test.txt

echo "Write a sed program to insert a line at the beginning of the file."
echo "Inserting 'Drone Test Log:' at the start of the file:"
sed '1i\Drone Test Log:' drone_test.txt

echo "Change multiple character strings in a file using sed."
echo "Using sed to change 'flying' to 'hovering' and 'area' to 'zone':"
sed -e 's/flying/hovering/' -e 's/area/zone/' drone_test.txt

echo "Use sed as a filter to modify file contents effectively."
echo "Filtering to only show lines containing 'UAV':"
sed -n '/UAV/p' drone_test.txt

exec bash --rcfile $RCFILE
