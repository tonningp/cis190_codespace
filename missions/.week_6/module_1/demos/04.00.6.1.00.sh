#!/bin/bash

echo "Demonstrate defining a shell variable and exporting it as an environment variable."

# Define a shell variable
echo 'Defining a shell variable: VAR="Hello, Drone Techs!"'
VAR="Hello, Drone Techs!"
echo "Shell variable VAR is set to: $VAR"

# Export the shell variable to make it an environment variable
echo "Exporting VAR to make it an environment variable."
export VAR
echo "Environment variable VAR is now exported with value: $VAR"

exec bash --rcfile $RCFILE
