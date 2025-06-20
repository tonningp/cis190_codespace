#!/bin/bash

echo "Demonstrate how to open a file in vim for editing."
echo "Command: vim <filename>"
echo "Example: vim drone_data.txt"

echo "Demonstrate how to access vim's online help."
echo "Command: :help"
echo "In vim, press ESC and type :help"

echo "Show how to switch between Command and Input modes."
echo "Command: Press 'i' to enter Input mode."
echo "Press ESC to return to Command mode."

echo "Demonstrate how to navigate text by words in vim."
echo "Command: Press 'w' to jump forward one word."
echo "Command: Press 'b' to jump backward one word."

echo "Demonstrate how to set a marker and navigate to it."
echo "Set a marker: Press 'm' followed by a letter (e.g., ma)"
echo "Navigate to marker: Press '\'' followed by the letter (e.g., 'a)"

echo "Demonstrate reading a file into the Work buffer."
echo "Command: :r <filename>"
echo "Example: :r additional_data.txt"

exec bash --rcfile $RCFILE
