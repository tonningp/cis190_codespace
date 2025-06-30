#!/bin/bash
# mission_template
# -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Managing Permissions in Drone Systems"
export lesson="$(cat<<EOF

**Learn to manage file and directory permissions to ensure secure and efficient drone system operations.**

> $(emoji lock) Applying correct permissions helps safeguard sensitive drone data and allows proper access to authorized personnel only.

***This lesson focuses on:***

1. Viewing Permissions:
   - Prompt: Use \`ls -l\` to display the permissions of a given directory.
   - Skill: Understand the current permission setup for files and directories.

2. Changing File Permissions:
   - Prompt: Use \`chmod\` to grant write permissions to the group for a specific configuration file.
   - Skill: Apply permission changes to manage access rights for specific user categories.

3. Setting Execute Permissions on Directories:
   - Prompt: Grant execute permissions to others for a directory to allow access.
   - Skill: Enable navigation and execution privileges for directories as needed.

4. Removing Permissions:
   - Prompt: Remove write permissions from others for a log file.
   - Skill: Restrict unnecessary access, securing system files.

5. Understanding Permissions with umask:
   - Prompt: Display and interpret the current \`umask\` value.
   - Skill: Pre-set default permissions for new files and directories.

EOF
)"

# Prepare a working environment
WORK_DIR="drone_permissions_exercises"
rm -rf $WORK_DIR 2>/dev/null
CONFIG_FILE="$WORK_DIR/config.conf"
LOG_FILE="$WORK_DIR/flight_log.txt"
TEST_DIR="$WORK_DIR/test_directory"

mkdir -p "$WORK_DIR"
touch "$CONFIG_FILE" "$LOG_FILE"
mkdir -p "$TEST_DIR"

# Set initial permissions for demonstration purposes
chmod 644 "$CONFIG_FILE"
chmod 644 "$LOG_FILE"
chmod 755 "$TEST_DIR"

# Training items
declare -g -a prompts=(
  "Use \`ls -l\` to display the permissions of '$WORK_DIR'."
  "Use \`chmod g+w $CONFIG_FILE\` to grant group write permissions."
  "Grant execute permissions to others for '$TEST_DIR' using \`chmod o+x $TEST_DIR\`."
  "Remove write permissions from others for '$LOG_FILE' with \`chmod o-w $LOG_FILE\`."
  "Use \`umask\` to display the current umask value and understand how it affects default permissions."
)

declare -g -a hints=(
  "Simply use \`ls -l $WORK_DIR\` to show detailed permissions."
  "To add write permissions to the group, use \`chmod g+w $CONFIG_FILE\`."
  "Grant execute permissions for navigation by using \`chmod o+x $TEST_DIR\`."
  "To secure the log file, execute \`chmod o-w $LOG_FILE\`."
  "The command \`umask\` provides the current mask that affects default permissions."
)

declare -g -a patterns=(
# re for workdir/ or workdir   
  "re:^ls +-l +$WORK_DIR/?$"
  "re:^chmod +g\+w +$CONFIG_FILE/?$"
  "re:^chmod +o\+x +$TEST_DIR/?$"
  "re:^chmod +o-w +$LOG_FILE/?$"
  "re:^umask$"
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

