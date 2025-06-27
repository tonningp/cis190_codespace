#!/bin/bash
## -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/utils.sh"
source "$TOP_DIR/emojis.sh"

lesson_title="Using the \`cat\` Command"
export lesson="$(cat<<EOF
**Learn how to use the \`cat\` command to view and manipulate file contents in the terminal.**

This lesson will give you hands-on practice with one of the most common and useful text utilities in Linux.

1. The basic syntax of the \`cat\` command is:
   \`\`\`
   cat filename
   \`\`\`

2. Display multiple files:
   \`\`\`
   cat file1.txt file2.txt
   \`\`\`

3. Number all output lines:
   \`\`\`
   cat -n filename
   \`\`\`

4. Redirect output to a new file:
   \`\`\`
   cat file1.txt > combined.txt
   \`\`\`

5. Append file contents to another file:
   \`\`\`
   cat file2.txt >> combined.txt
   \`\`\`
EOF
)"

# Training items: expected commands
declare -g -a prompts=(
  "Use the $(cyan 'cat') command to view the contents of a file named $(cyan 'file.txt')"
  "Use the $(cyan 'cat') command to display two files: $(cyan 'file1.txt') and $(cyan 'file2.txt')"
  "Use the $(cyan 'cat') command with an option to number all lines of $(cyan 'file.txt')"
  "Use the $(cyan 'cat') command to redirect the contents of $(cyan 'file1.txt') into $(cyan 'combined.txt')"
  "Use the $(cyan 'cat') command to append the contents of $(cyan 'file2.txt') to $(cyan 'combined.txt')"
)

declare -g -a hints=(
  "Use: \`cat file.txt\`"
  "Use: \`cat file1.txt file2.txt\`"
  "Use the \`-n\` flag: \`cat -n file.txt\`"
  "Use \`>\` to redirect output: \`cat file1.txt > combined.txt\`"
  "Use \`>>\` to append output: \`cat file2.txt >> combined.txt\`"
)

declare -g -a patterns=(
  "cat file.txt"
  "cat file1.txt file2.txt"
  "cat -n file.txt"
  "cat file1.txt > combined.txt"
  "cat file2.txt >> combined.txt"
)

declare -g -a evals=(
  1
  1
  1
  1
  1
)

# Setup files for the lesson
echo "Hello from file.txt" > file.txt
echo -e "This is file1.txt\nLine B" > file1.txt
echo -e "This is file2.txt\nLine D" > file2.txt
rm -f combined.txt
# Create the combined file if it doesn't exist
source ${TOP_DIR}/lesson_manager.sh
exec bash --rcfile $RCFILE

