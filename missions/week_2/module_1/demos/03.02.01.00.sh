#!/bin/bash
## -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Listing Files with ls"
export lesson="$(cat<<EOF

**In this lesson, you will learn how to list files and directories using the \`ls\` command with different options.**

Understanding how to view files and directories is one of the first steps in navigating a Linux system.

1. The \`ls\` command lists directory contents.

1. Important options:
   - \`-l\`: Long listing format
   - \`-a\`: Include hidden files (those beginning with .)
   - \`-h\`: Human-readable file sizes (used with \`-l\`)
   - \`-R\`: Recursively list subdirectories
   - \`-t\`: Sort by modification time

In this lesson, you will demonstrate use of these options correctly and interpret the output.
EOF
)"

mkdir -p testdir/subdir
touch testdir/.hidden_file testdir/file1 testdir/file2 testdir/subdir/file3

# Training items: expected commands
declare -g -a prompts=(
"List all files in the current directory"
"Use the long listing format to view file details"
"List all files including hidden ones"
"Recursively list contents of testdir"
"List files in testdir sorted by modification time"
)

declare -g -a hints=(
  "Use the \`ls\` command by itself to see file names."
  "Add the \`-l\` option to see permissions, owner, size, etc."
  "Use the \`-a\` option to include hidden files."
  "Use the \`-R\` option to list directories and their contents recursively."
  "Combine \`-t\` with the directory name."
)

declare -g -a patterns=(
  "ls"
  "ls -l"
  "ls -a"
  "ls -R testdir"
  "ls -t testdir"
)

declare -g -a evals=(
  1
  1
  1
  1
  1
)

source "${TOP_DIR}/lesson_manager.sh"

