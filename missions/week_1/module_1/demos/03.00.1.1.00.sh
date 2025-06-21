#!/bin/bash
source ${BASE_DIR}/demos/environ.sh
clear
cat <<EOF
********************************************************************************
Review Exercise:
1. Call the command to print the working directory.
2. Type in a comment $(cyan "Linux is awesome!") followed by the Enter key to add a comment in the shell.
3. Find out what kernel this shell is running in.
EOF
#echo "Demonstrate how to view command history and repeat past commands in the shell."
#
## Display the command history
#echo "Displaying command history:"
#echo "history"
#
## Re-execute the last command
#echo "Re-executing the last command:"
#echo "!!"
#
## Execute a specific command from history (e.g., command number 5)
#echo "Executing a specific command from history (replace 5 with the desired command number):"
#echo "!5"

exec bash --rcfile $RCFILE
