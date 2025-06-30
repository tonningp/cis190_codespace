#!/bin/bash

echo "Demonstrate how to configure vim with parameters for efficient editing."
echo "1. Open vim: vim"
echo "2. Display line numbers: :set number"
echo "3. Enable case-insensitive search: :set ignorecase"
echo "4. Enable line wrapping with a margin of 15: :set wrapmargin=15"
echo "5. For consistency, add these settings to your .vimrc file."

exec bash --rcfile $RCFILE
