#!/bin/bash
# mission_template
# -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Understanding Directory Files and Ordinary Files"
export lesson="$(cat<<EOF

**Gain a deeper understanding of the roles of directory files and ordinary files in a filesystem, and learn how to utilize them for effective file management.**

> $(emoji closed_book) Mastering the distinction and uses of directory and ordinary files is crucial for organizing data efficiently and leveraging tree structures fully.

***This lesson focuses on:***

1. Identify Ordinary Files:
   - Prompt: List ordinary files in the 'documents' directory.
   - Skill: Recognize files that contain data or programs.

2. Create and Manipulate Directory Files:
   - Prompt: Create a new directory for 'projects' within your existing directory structure.
   - Skill: Use directory files to organize and house collections of data.

3. Traverse through Directory Files:
   - Prompt: Navigate through the 'projects' directory tree and list its contents.
   - Skill: Practice navigating directory files and understanding file hierarchy.

4. Convert Ordinary Files to Directory Files:
   - Prompt: Recreate an ordinary file as a directory.
   - Skill: Understand the properties and use cases of directory files versus ordinary files.

5. Use Tree Structures for Efficient Management:
   - Prompt: Display a tree structure view of your overall directory hierarchy.
   - Skill: Utilize tree structures for visual representation and management of file systems.

EOF
)"

# Prepare a working environment
BASE_DIR="filesystem_exercises"
DOC_DIR="$BASE_DIR/documents"
PROJECT_DIR="$BASE_DIR/projects"
touch "$DOC_DIR/report.txt" "$DOC_DIR/data.csv"
mkdir -p "$DOC_DIR" "$PROJECT_DIR"

# Training items
declare -g -a prompts=(
  "List ordinary files in the '$DOC_DIR'."
  "Create a new directory named 'designs' within the '$PROJECT_DIR'."
  "Navigate through the '$PROJECT_DIR' and list its contents."
  "Recreate '$DOC_DIR/tempfile.txt' as a directory 'tempfile'."
  "Display a tree structure view of your '$BASE_DIR'."
)

declare -g -a hints=(
  "Use \`ls $DOC_DIR\` to list ordinary files, which store data or programs."
  "Create directory using \`mkdir $PROJECT_DIR/designs\` to organize projects."
  "Navigate to \`cd $PROJECT_DIR\` and use \`ls\` to explore directory files."
  "Remove ordinary file with \`rm $DOC_DIR/tempfile.txt\` before using \`mkdir\`."
  "Utilize \`tree $BASE_DIR\` command to view directory hierarchy."
)

declare -g -a patterns=(
  "ls $DOC_DIR"
  "mkdir $PROJECT_DIR/designs"
  "cd $PROJECT_DIR && ls"
  "rm $DOC_DIR/tempfile.txt && mkdir $DOC_DIR/tempfile"
  "tree $BASE_DIR"
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
