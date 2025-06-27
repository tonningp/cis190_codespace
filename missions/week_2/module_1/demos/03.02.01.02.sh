#!/bin/bash
## -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Removing Files Safely with \`rm\`"
export lesson="$(cat<<EOF

**Demonstrate how to use the \`rm\` command to remove files and directories safely.**

This lesson focuses on:
1. Basic usage of \`rm\`
2. Using options like \`-i\` for confirmation
3. Removing multiple files
4. Preventing accidental deletion
5. Removing empty directories using \`rmdir\`

> ⚠️ Be very careful with \`rm\`. Files deleted this way do not go to a "trash" bin—they are permanently removed.
EOF
)"

# Prepare a working environment
mkdir -p tempdir
touch tempdir/file1.txt tempdir/file2.txt file3.txt
cp file3.txt file3_backup.txt

# Training items
declare -g -a prompts=(
  "Delete the file named file3.txt using the $(cyan 'rm') command"
  "Delete file1.txt from the tempdir directory"
  "Use $(cyan 'rm -i') to delete file2.txt with confirmation"
  "Remove multiple files: file3_backup.txt and file2.txt from tempdir"
  "Remove the empty directory named tempdir"
)

declare -g -a hints=(
  "Use \`rm filename\` to delete a file."
  "Use the correct path with \`rm\`."
  "Use \`-i\` to get prompted for confirmation."
  "Pass multiple filenames to \`rm\` separated by a space."
  "Use \`rmdir\` for deleting empty directories (not \`rm\`)."
)

declare -g -a patterns=(
  "rm file3.txt"
  "rm tempdir/file1.txt"
  "rm -i tempdir/file2.txt"
  "rm file3_backup.txt tempdir/file2.txt"
  "rmdir tempdir"
)

declare -g -a evals=(
  1
  1
  1
  1
  1
)

source "${TOP_DIR}/lesson_manager.sh"
