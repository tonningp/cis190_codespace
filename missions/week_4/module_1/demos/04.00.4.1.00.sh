#!/bin/bash

echo "Demonstrate how to open a file in vim and switch between different modes."

echo "1. Open a file with vim:"
echo "   vim example.txt"

echo "2. Switch to Input Mode by pressing 'i'."
echo "   You can now enter text directly into the file."

echo "3. Return to Command Mode by pressing 'ESCAPE'."
echo "   In this mode, you can enter commands like deleting text."

echo "4. To enter Last Line Mode, press ':' while in Command Mode."
echo "   For example, type ':set number' and press 'Enter' to enable line numbers."

exec bash --rcfile $RCFILE
