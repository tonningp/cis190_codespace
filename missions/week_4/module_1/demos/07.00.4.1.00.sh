#!/bin/bash

echo "Demonstrating advanced text correction and navigation in a text editor."

echo "1. To delete a character, use the 'x' command."
echo "2. To undo the last change, use the 'u' command."
echo "3. To redo the last undone change, use 'CONTROL-R'."
echo "4. Navigate with 'h', 'j', 'k', 'l', or arrow keys."
echo "5. Use 'w' to move forward by word and 'b' to move backward by word."
echo "6. Use '0' to go to the start of a line and '$' to go to the end of a line."

echo "Practice these commands to enhance your efficiency in text editing, which is crucial for quick log reviews and updates."

exec bash --rcfile $RCFILE
