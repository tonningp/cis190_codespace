#!/bin/bash

echo "Demonstrate how to use the directory stack commands: dirs, pushd, and popd."

echo "1. Use 'dirs' to display the current directory stack:"
echo "dirs"

echo "2. Use 'pushd' to add a directory to the stack and change to it:"
echo "pushd /path/to/your/directory"

echo "3. Use 'popd' to remove the top directory from the stack and change to the previous one:"
echo "popd"

echo "Demonstrate how to set and use shell variables."

echo "4. Create a user-defined shell variable and display its value:"
echo "MY_VARIABLE='Hello, Drone World'"
echo "echo \$MY_VARIABLE"

echo "5. Display the value of a keyword shell variable:"
echo "echo \$PATH"

exec bash --rcfile $RCFILE
