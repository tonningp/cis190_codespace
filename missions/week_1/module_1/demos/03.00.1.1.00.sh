#!/bin/bash

echo "Demonstrate how to view command history and repeat past commands in the shell."

# Display the command history
echo "Displaying command history:"
echo "history"

# Re-execute the last command
echo "Re-executing the last command:"
echo "!!"

# Execute a specific command from history (e.g., command number 5)
echo "Executing a specific command from history (replace 5 with the desired command number):"
echo "!5"

exec bash --rcfile $RCFILE
