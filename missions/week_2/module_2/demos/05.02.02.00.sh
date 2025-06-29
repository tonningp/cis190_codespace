#!/bin/bash
# mission_template
# -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Mastering Pathnames in the Filesystem"
export lesson="$(cat<<EOF

**Develop skills in working with both absolute and relative pathnames to efficiently navigate the Linux filesystem.**

> $(emoji compass) Understanding and using pathnames accurately is essential for effective file and directory management in Linux environments.

***This lesson focuses on:***

1. Display Current Directory:
   - Prompt: Use `pwd` to display your current working directory.
   - Skill: Verify your position within the filesystem.

2. Navigate Using Absolute Path:
   - Prompt: Navigate to the home directory using its absolute path.
   - Skill: Access directories using absolute pathnames.

3. Navigate Using Relative Path:
   - Prompt: From your current directory, use a relative path to go into 'documents'.
   - Skill: Efficiently shift directories using relative pathnames.

4. Practice Switching Directories:
   - Prompt: Use both absolute and relative paths to switch back to the previous directory.
   - Skill: Gain versatility in navigation through different pathname types.

5. Create and Verify Directories:
   - Prompt: Create a new directory using an absolute path. Confirm with 'pwd'.
   - Skill: Combine pathname understanding with directory creation.

EOF
)"

# Prepare a working environment
BASE_DIR="$HOME/pathname_exercises"
DOC_DIR="documents"
mkdir -p "$BASE_DIR/$DOC_DIR"

# Training items
declare -g -a prompts=(
  "Use \`pwd\` to display your current working directory."
  "Navigate to your home directory using its absolute path: \`$HOME\`."
  "From '$BASE_DIR', use a relative path to navigate to '$DOC_DIR'."
  "Switch back to previous directory \`$BASE_DIR\` using one absolute and one relative path method."
  "Create a directory within '$BASE_DIR/new_dir' using an absolute path and verify with \`pwd\`."
)

declare -g -a hints=(
  "Simply use \`pwd\` to show your current directory."
  "Use \`cd $HOME\` to move to the home directory with an absolute path."
  "If already in '$BASE_DIR', use \`cd $DOC_DIR\` to navigate into documents."
  "Switching back: use \`cd $BASE_DIR\` (absolute) and \`cd ..\` (relative if you are in '$DOC_DIR')."
  "Create \`$BASE_DIR/new_dir\` with \`mkdir -p $BASE_DIR/new_dir\`; confirm with \`cd $BASE_DIR/new_dir && pwd\`."
)

declare -g -a patterns=(
  "pwd"
  "cd $HOME"
  "cd $DOC_DIR"
  "cd .. && cd $BASE_DIR"
  "mkdir -p $BASE_DIR/new_dir && cd $BASE_DIR/new_dir && pwd"
)

declare -g -a evals=(
  1
  1
  1
  1
  1
)

export TREE_VIEW="$(tree -C $BASE_DIR)"
source "${TOP_DIR}/lesson_manager.sh"
