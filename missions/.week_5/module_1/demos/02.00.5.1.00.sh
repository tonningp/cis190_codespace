#!/bin/bash

echo "Demonstrate how to customize your environment by setting and displaying a variable."

echo "Creating a variable that stores the drone model name."
echo "export DRONE_MODEL='X2000'"

echo "Displaying the variable content."
echo "echo \$DRONE_MODEL"

exec bash --rcfile $RCFILE
