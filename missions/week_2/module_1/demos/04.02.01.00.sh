#!/bin/bash
## -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Copying Files with \`cp\`"
export lesson="$(cat<<EOF

**Demonstrate how to use the \`cp\` command to copy files and directories.**

This lesson focuses on:
1. Basic file copying
2. Copying and renaming
3. Copying into directories
4. Copying multiple files
5. Copying directories recursively with \`-r\`

> 💡 Use \`cp -i\` to avoid accidentally overwriting files.
EOF
)"

# Prepare a working environment
mkdir -p dir1 dir2
touch file1.txt file2.txt
echo "Sample content" > dir1/nested.txt

# Training items
declare -g -a prompts=(
  "Copy file1.txt to file1_copy.txt using the $(cyan 'cp') command"
  "Copy file2.txt into the dir1 directory"
  "Copy both file1.txt and file2.txt into dir2"
  "Copy the file dir1/nested.txt to the current directory"
  "Recursively copy the entire dir1 directory into dir2"
)

declare -g -a hints=(
  "Use \`cp source destination\`."
  "Use the format: \`cp file dir/\`."
  "List both source files, then the target directory."
  "Make sure to preserve the filename when copying."
  "Use \`cp -r\` to copy directories."
)

declare -g -a patterns=(
  "cp file1.txt file1_copy.txt"
  "cp file2.txt dir1/"
  "cp file1.txt file2.txt dir2/"
  "cp dir1/nested.txt ./"
  "cp -r dir1 dir2/"
)

declare -g -a evals=(
  1
  1
  1
  1
  1
)

source "${TOP_DIR}/lesson_manager.sh"

