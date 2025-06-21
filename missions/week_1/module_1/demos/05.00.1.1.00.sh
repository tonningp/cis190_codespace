#!/bin/bash
source ${BASE_DIR}/demos/environ.sh
clear
cat <<EOF
To list all available shells on the system:
Run this command: 
$(cyan "cat /etc/shells")

$(bold "cat") is a command that reads the contents of files and outputs them to the terminal.
EOF
#echo "Demonstrate how to check the Linux kernel version and list all available shells on the system."
#
#echo "To check the Linux kernel version:"
#echo "uname -r"
#
#echo "To list all available shells on the system:"
#echo "cat /etc/shells"

exec bash --rcfile $RCFILE
