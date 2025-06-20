#!/bin/bash

echo "Demonstrate how to access vim help and perform emergency exits."

echo "1. To access help on a particular feature, use the command:"
echo ":help [feature]"
echo "   Example: :help insert"
echo

echo "2. To scroll through the help documentation, use:"
echo "'j' to scroll down, 'k' to scroll up, 'CONTROL-D' to scroll half a page down, and 'CONTROL-U' to scroll half a page up."
echo

echo "3. To exit help, use the command:"
echo ":q"
echo

echo "4. For emergency exits from vim, use the command:"
echo ":q!"
echo

exec bash --rcfile $RCFILE
