#!/bin/bash

echo "Demonstrate how to use sed with a program file to print specific lines in a file."
echo "Creating a program file named 'print3_6' to print lines 3 to 6:"
echo -e "3,6 p" > print3_6
echo "Executing sed with the program file on a file named 'lines':"
echo "sed -n -f print3_6 lines"

echo "Demonstrate how to use sed to append text after a specific line."
echo "Creating a program file named 'append_demo' to append 'AFTER.' after line 2:"
echo -e "2 a\\\nAFTER." > append_demo
echo "Executing sed with the program file on a file named 'lines':"
echo "sed -f append_demo lines"

echo "Demonstrate how to use sed to change specific lines."
echo "Creating a program file named 'change_demo' to replace lines 2 to 4:"
echo -e "2,4 c\\\nSED WILL INSERT THESE\\\nTHREE LINES IN PLACE\\\nOF THE SELECTED LINES." > change_demo
echo "Executing sed with the program file on a file named 'lines':"
echo "sed -f change_demo lines"

exec bash --rcfile $RCFILE
