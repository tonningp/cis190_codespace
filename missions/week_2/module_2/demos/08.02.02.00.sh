#!/bin/bash
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"
source "$TOP_DIR/venv/bin/activate"

echo "Demonstrate how to display file permissions and modify them."

echo "1. Use 'ls -l' to list files with their permissions."
echo "   Command: ls -l"
echo

echo "2. Modify permissions using 'chmod'. For example, add read and write permissions for all users on 'file.txt'."
echo "   Command: chmod a+rw file.txt"
echo
export lesson=$(cat<<EOF
**Demonstrate how to display file permissions and modify them.**
> $(emoji lock) Understanding file permissions is crucial for maintaining security and proper access control in Linux systems.
EOF
)

export lesson_title="# Displaying and Modifying File Permissions"
echo $lesson_title | python -m rich.markdown -w 80 -y -

lesson=$lesson exec bash --rcfile $RCFILE
