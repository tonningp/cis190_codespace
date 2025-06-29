#!/bin/bash
# mission_template
# -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Understanding the Linux Filesystem"
export lesson="$(cat<<EOF

**Learn about the Linux filesystem hierarchy and key directory concepts.**

> $(emoji open_file_folder) Understanding how files and directories are structured is crucial for efficient navigation and management of a Linux system.

***This lesson focuses on:***

1. Hierarchical Filesystem Structure:
   - Explore the top-level directories and understand their purpose.
   - Understand the hierarchical organization of the Linux filesystem.

2. Ordinary Files vs Directory Files:
   - Identify the difference between ordinary files and directory files.
   - Recognize different file types in the filesystem.

3. Home Directory:
   - Locate and describe the function of your home directory.
   - Identify and navigate to the home directory.

4. Working Directory:
   - Determine your current working directory and change directories.
   - Skill: Use commands to manage and navigate between directories.

5. Parent Directory:
   - Navigate to the parent directory of your current location.
   - Understand and utilize the hierarchical nature of directories.

EOF
)"

# Prepare a working environment
USER_HOME="home/$(whoami)"
WORK_DIR="$USER_HOME/projects"
PARENT_DIR="$USER_HOME"

# Create directories and files to illustrate the concepts
mkdir -p "$USER_HOME" "$WORK_DIR"
touch "$WORK_DIR/ordinary_file.txt"
mkdir -p "$WORK_DIR/directory_file"

# Training items
declare -g -a prompts=(
  "Explore the top-level directories using \`ls /\` and understand their roles in the Linux filesystem."
  "Identify the difference between ordinary files and directories in $WORK_DIR using \`ls -l\`."
  "Locate your home directory using \`echo $HOME\` and describe its purpose."
  "Display your current working directory using \`pwd\`, then change to the $WORK_DIR using \`cd\`."
  "Move to the parent directory of $WORK_DIR using \`cd ..\` and confirm your location with \`pwd\`."
)

declare -g -a hints=(
  "Use \`ls /\` to list top-level directories such as /bin, /etc, /home, and /usr."
  "Use \`ls -l\` to differentiate files from directories based on file type character in the output."
  "The home directory is typically found in /home/your-username and is represented by \`$HOME\`."
  "Use \`pwd\` to print the current directory path and \`cd <directory>\` to change directories."
  "Navigate up one level from your current directory with \`cd ..\` and confirm the new path using \`pwd\`."
)

declare -g -a patterns=(
  "ls /"
  "ls -l $WORK_DIR"
  "echo $HOME"
  "pwd && cd $WORK_DIR"
  "cd .. && pwd"
)

declare -g -a evals=(
  1
  1
  1
  1
  1
)

export TREE_VIEW="$(tree -C -L 2 $USER_HOME)"
source "${TOP_DIR}/lesson_manager.sh"
