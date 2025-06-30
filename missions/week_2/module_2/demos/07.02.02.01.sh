#!/bin/bash
# mission_template
# -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Mastering File Links for Drone Systems"
export lesson="$(cat<<EOF

**Learn to create and manage file links within Linux to optimize drone system file management.**

> $(emoji link) Using file links effectively allows for efficient data management and access across various drone system files.

***This lesson focuses on:***

1. Creating a Hard Link:
   - Prompt: Use \`ln\` to create a hard link from a configuration file.
   - Skill: Understand the process of creating additional access points for critical files within the same filesystem.

2. Creating a Symbolic Link:
   - Prompt: Use \`ln -s\` to create a symbolic link to a mission log file located on a different partition.
   - Skill: Facilitate flexible file access across filesystems.

3. Viewing Link Details:
   - Prompt: Use \`ls -l\` to view details of both hard and symbolic links.
   - Skill: Identify characteristics and targets of different link types.

4. Dereferencing Symbolic Links:
   - Prompt: Use \`ls -lL\` to dereference and display the target file details of a symbolic link.
   - Skill: Access actual file contents via a symbolic link.

5. Removing a Symbolic Link:
   - Prompt: Use \`rm\` to safely remove a symbolic link without affecting the original file.
   - Skill: Manage cleanup of obsolete links to maintain a tidy file system.

EOF
)"

# Prepare a working environment
WORK_DIR="drone_link_exercises"
rm -rf $WORK_DIR 2>/dev/null
CONFIG_FILE="$WORK_DIR/config.txt"
LOG_FILE="$WORK_DIR/mission_logs/flight.log"
mkdir -p "$WORK_DIR/mission_logs"
touch "$CONFIG_FILE" "$LOG_FILE"

# Training items
declare -g -a prompts=(
  "Create a hard link named \`config_hlink\` for \`$CONFIG_FILE\`.  Pay attention to directory structure."
  "Create a symbolic link named \`log_slink\` for the log file \`$LOG_FILE\`."
  "Use \`ls -l\` to list details of \`config_hlink\` and \`log_slink\`."
  "Use \`ls -lL log_slink\` to display details of the link's target file."
  "Remove the symbolic link \`log_slink\` using \`rm\`."
)

declare -g -a hints=(
  "Use \`ln $CONFIG_FILE $WORK_DIR/config_hlink\` to create a hard link.  Pay attention to the directory structure."
  "Use \`ln -s $LOG_FILE $WORK_DIR/log_slink\` for the symbolic link."
  "Simply \`ls -l $WORK_DIR/config_hlink $WORK_DIR/log_slink\` to see link details."
  "To view the target details, use \`ls -lL $WORK_DIR/log_slink\`."
  "Execute \`rm $WORK_DIR/log_slink\` to delete the symbolic link."
)

declare -g -a patterns=(
  "re:^ln +$CONFIG_FILE +$WORK_DIR/config_hlink$"
  "re:^ln +-s +$LOG_FILE +$WORK_DIR/log_slink$"
  "re:^ls +-l +$WORK_DIR/config_hlink +$WORK_DIR/log_slink$"
  "re:^ls +-lL +$WORK_DIR/log_slink$"
  "re:^rm +$WORK_DIR/log_slink$"
)

declare -g -a evals=(
  1
  1
  1
  1
  1
)

export TREE_VIEW="$(tree -C $WORK_DIR)"
source "${TOP_DIR}/lesson_manager.sh"

