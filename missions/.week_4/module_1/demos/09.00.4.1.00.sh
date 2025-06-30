#!/bin/bash

echo "Demonstrate how to use text manipulation commands to manage drone flight logs and scripts."

echo "Yank (copy) a line of text:"
echo "Use the command 'yy' to copy a line in a text editor like Vim."

echo "Delete a line of text:"
echo "Use the command 'dd' to delete a line in a text editor like Vim."

echo "Put (paste) the yanked or deleted text:"
echo "Use 'p' to paste text below the current line or 'P' to paste text above the current line."

echo "Delete a word:"
echo "Use 'dw' to delete a word from the cursor's position in a text editor like Vim."

exec bash --rcfile $RCFILE
