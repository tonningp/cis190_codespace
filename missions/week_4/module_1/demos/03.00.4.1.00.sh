#!/bin/bash

echo "Demonstrate how to start vim and create/edit a file named 'practice'."
echo "Command:"
echo "vim practice"

echo "Discuss initial screen indicators in vim:"
echo "- Tildes (~) indicate an empty file."
echo "- The status line provides file creation/editing information."

echo "If terminal issues occur, reset with:"
echo ":q!"

exec bash --rcfile $RCFILE
