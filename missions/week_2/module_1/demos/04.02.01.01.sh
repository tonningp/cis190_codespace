#!/bin/bash
## -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Moving and Renaming with \`mv\`"
export lesson="$(cat<<EOF

**Demonstrate how to use the \`mv\` command to move or rename files and directories.**

This lesson focuses on:
1. Renaming a file
2. Moving a file to another directory
3. Moving and renaming simultaneously
4. Moving multiple files into a directory
5. Moving a directory

> 📁 Remember that \`mv\` overwrites the destination without warning. Use \`-i\` to be prompted before overwriting.
EOF
)"

# Prepare a working environment
mkdir -p move_dir/subdir
touch oldname.txt file1.txt file2.txt
cp oldname.txt move_dir/

# Training items
declare -g -a prompts=(
  "Rename oldname.txt to newname.txt using the $(cyan 'mv') command"
  "Move file1.txt into move_dir"
  "Move and rename file2.txt to move_dir/renamed.txt"
  "Move both file1.txt and file2.txt into move_dir"
  "Move the subdir directory into the parent directory"
)

declare -g -a hints=(
  "Use \`mv source target\` to rename a file."
  "Use the format: \`mv file dir/\`."
  "Specify a new name in the destination path."
  "List the files then the target directory."
  "Use \`mv dir1 target_dir/\` to move a directory."
)

declare -g -a patterns=(
  "mv oldname.txt newname.txt"
  "mv file1.txt move_dir/"
  "mv file2.txt move_dir/renamed.txt"
  "mv file1.txt file2.txt move_dir/"
  "mv move_dir/subdir ./"
)

declare -g -a evals=(
  1
  1
  1
  1
  1
)

source "${TOP_DIR}/lesson_manager.sh"

