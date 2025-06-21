#!/bin/bash
source $BASE_DIR/demos/environ.sh
clear
cat <<EOS
********************************************************************************
Demonstrate correcting mistakes and repeating commands in the shell.

1: Correcting Mistakes
Type a command and use the BACKSPACE key to erase characters if needed.

2: Set default erase and line kill keys using 'stty ek'.
$(cyan 'stty ek')
Default erase and line kill keys set.

3: Repeating Commands
Use the UP and DOWN ARROW keys to browse command history.

4: Use $(cyan '!!') to repeat the last command.
For example, type a command (e.g., 'echo Hello') and then type '!!' to repeat it.

EOS
# use this later
#Use '^old^new^' to replace strings in the previous command.
#For example, after typing 'echo Hello', use '^Hello^World^' to change it to 'echo World'.
#
exec bash --rcfile $RCFILE
