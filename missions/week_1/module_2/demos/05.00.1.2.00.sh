#!/bin/bash

echo "Demonstrate correcting mistakes and repeating commands in the shell."

echo "Step 1: Correcting Mistakes"
echo "Type a command and use the BACKSPACE key to erase characters if needed."

echo "Step 2: Set default erase and line kill keys using 'stty ek'."
stty ek
echo "Default erase and line kill keys set."

echo "Step 3: Repeating Commands"
echo "Use the UP and DOWN ARROW keys to browse command history."

echo "Use '!!' to repeat the last command."
echo "For example, type a command (e.g., 'echo Hello') and then type '!!' to repeat it."

echo "Use '^old^new^' to replace strings in the previous command."
echo "For example, after typing 'echo Hello', use '^Hello^World^' to change it to 'echo World'."

exec bash --rcfile $RCFILE
