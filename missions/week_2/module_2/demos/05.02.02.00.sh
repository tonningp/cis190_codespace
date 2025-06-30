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
   - Prompt: Use \`pwd\` to display your current working directory.
   - Skill: Verify your position within the filesystem.

2. Navigate Using Absolute Path:
   - Prompt: Navigate to the home directory using its absolute path.
   - Skill: Access directories using absolute pathnames.

3. Navigate Using Relative Path:
   - Prompt: From your current directory, use a relative path to go into \`documents\`.
   - Skill: Efficiently shift directories using relative pathnames.

4. Practice Switching Directories:
   - Prompt: Use both absolute and relative paths to switch back to the previous directory.
   - Skill: Gain versatility in navigation through different pathname types.

5. Create and Verify Directories:
   - Prompt: Create a new directory using an absolute path. Confirm with \`pwd\`.
   - Skill: Combine pathname understanding with directory creation.

EOF
)"

# Prepare a working environment
WORK_DIR="NavigationPractice"
rm -rf "$WORK_DIR" 2>/dev/null
DOC_DIR="documents"
mkdir -p "$WORK_DIR/$DOC_DIR"

# Training items
declare -g -a prompts=(
  "Use \`pwd\` to display your current working directory."
  "Navigate to your home directory using its absolute path: \`$HOME\`."
)

declare -g -a hints=(
  "Simply use \`pwd\` to show your current directory."
  "Use \`cd $HOME\` to move to the home directory with an absolute path."
)

declare -g -a patterns=(
"re:^pwd$"
"re:^cd +$HOME/?$"
)

declare -g -a evals=(
  1
  1
)

export TREE_VIEW="$(tree -C $WORK_DIR 2>/dev/null)"
source "${TOP_DIR}/lesson_manager.sh"

