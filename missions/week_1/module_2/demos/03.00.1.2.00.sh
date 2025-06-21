#!/bin/bash
source $BASE_DIR/demos/environ.sh
clear

cat <<EOS
Demonstrate how to view the contents of a file using the cat command.

To creating a sample file named practice with some text, use the
following command.

echo "This is a sample text file for demonstration purposes." > practice

Exercise:
1. Create a file named 'practice' with some text in it.
   Use the command:
   $(cyan 'echo "This is a sample text file for demonstration purposes." > practice')

2. View the contents of the file using the cat command.

Command: $(cyan 'cat practice')

EOS

exec bash --rcfile $RCFILE
