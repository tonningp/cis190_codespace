#!/bin/bash

echo "Demonstrate how to start vim, enter text, navigate, correct text, save files, and exit vim."

echo "1. Start vim by typing: vim example.txt"
echo "2. Enter insert mode by pressing: i"
echo "3. Type some text, for example: Drone system documentation"
echo "4. Navigate using arrow keys, and correct text using backspace or by pressing: x"
echo "5. Save the file by pressing: Esc, then type :w"
echo "6. Exit vim by typing: :q"

exec bash --rcfile $RCFILE
