#!/bin/bash
source ${BASE_DIR}/demos/environ.sh
clear
cat <<EOF
************ $(bold "Comments and the Linux kernel version") *****************************
A comment in the shell is a line of text that is not executed as a command.
Comments start with a hash symbol (#).
For example, if the line below is typed in, it is a comment and will not be executed.

$(cyan "# This is a comment.")

The linux kernel is the core part of the Linux operating system.  It is not a 
program, but rather a collection of code that manages the hardware and software

The command to check the Linux kernel version in use is:
$(yellow "uname -r")

For this exercise:
1. Type the comment $(cyan "# hello I am a comment") followed by the Enter key to 
   add a comment in the shell.  Try typing it without the hash symbol to see the
   difference.
2. Type in the command $(yellow 'uname -r') followed by the Enter key to see the 
   version of the Linux kernel.
EOF
AFTER_COMMANDS=$(cat <<'EOS'
echo 'this is an echo'
echo 'another line'
EOS
)
(AFTER_COMMANDS="$AFTER_COMMANDS" exec bash --rcfile $RCFILE)
