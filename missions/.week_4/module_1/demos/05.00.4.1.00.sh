#!/bin/bash

echo "Demonstrate entering Input mode in vim using 'i' and typing text."

echo "Open a file in vim:"
echo "vim sample.txt"

echo "Enter Insert mode by pressing 'i' and type the following text:"
echo "This is a sample paragraph."

echo "Correct mistakes using backspace or word-kill keys if necessary."

echo "Press 'ESCAPE' to return to Command mode."

echo "Remember to press 'RETURN' before reaching line ends for structured drone logs."

exec bash --rcfile $RCFILE
