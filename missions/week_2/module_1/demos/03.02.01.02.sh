#!/bin/bash
# mission_template
# -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Removing Files with rm"
export lesson="$(cat<<EOF

**Learn to use the \`rm\` command to safely and effectively remove drone configuration files and logs.**

> $(emoji warning) When using \`rm\`, ensure that you double-check the files you're deleting, as recovery can be difficult.

***This lesson focuses on:***
1. Remove a Single File:
   - Prompt: Delete the temporary file temp.txt in the config directory.
   - Skill: Basic use of \`rm\` to remove a single file.

2. Force Remove a File:
   - Prompt: Forcefully remove the file locked.log in the logs directory.
   - Skill: Use the \`-f\` option with \`rm\` to remove files without prompting for confirmation.

3. Remove an Empty Directory:
   - Prompt: Remove the empty directory named archive in the drone_data directory.
   - Skill: Use the \`rmdir\` command to remove a directory that doesn't contain any files.

4. Remove a Directory with Contents:
   - Prompt: Remove the samples directory within the drone_data directory and all its contents.
   - Skill: Use the \`-r\` option with \`rm\` to recursively delete a directory and its contents.

5. Interactive Deletion:
   - Prompt: Use interactive mode to delete the obsolete.conf file in the config directory.
   - Skill: Use the \`-i\` option to confirm deletion of each file.
EOF
)"

# Prepare a working environment
ROOT_DIR='drone_data'
CONFIG_DIR="$ROOT_DIR/config"
LOG_DIR="$ROOT_DIR/logs"
ARCHIVE_DIR="$ROOT_DIR/archive"
SAMPLES_DIR="$ROOT_DIR/samples"
mkdir -p "$CONFIG_DIR" "$LOG_DIR" "$ARCHIVE_DIR" "$SAMPLES_DIR"

# Create some sample files and directories
echo "Temporary data" > ${CONFIG_DIR}/temp.txt
echo "Locked content" > ${LOG_DIR}/locked.log
touch ${CONFIG_DIR}/obsolete.conf
touch ${SAMPLES_DIR}/sample1.txt
touch ${SAMPLES_DIR}/sample2.txt

# Training items
declare -g -a prompts=(
  "Delete the temporary file temp.txt in the ${CONFIG_DIR} directory using \`rm\`."
  "Forcefully remove the file locked.log in the ${LOG_DIR} directory using \`rm -f\`."
  "Remove the empty directory named archive in the ${ROOT_DIR} directory using \`rmdir\`."
  "Remove the samples directory within the ${ROOT_DIR} directory and all its contents using \`rm -r\`."
  "Use interactive mode to delete the obsolete.conf file in the ${CONFIG_DIR} directory."
)

declare -g -a hints=(
  "Use \`rm <filename>\` to remove a single file."
  "Use \`rm -f <filename>\` to forcefully remove files without prompts."
  "Use \`rmdir <directory>\` to remove an empty directory."
  "Use \`rm -r <directory>\` to recursively remove a directory and its contents."
  "Use \`rm -i <filename>\` to interactively confirm deletion."
)

declare -g -a patterns=(
  "rm ${CONFIG_DIR}/temp.txt"
  "rm -f ${LOG_DIR}/locked.log"
  "rmdir ${ARCHIVE_DIR}"
  "rm -r ${SAMPLES_DIR}"
  "rm -i ${CONFIG_DIR}/obsolete.conf"
)

declare -g -a evals=(
  1
  1
  1
  1
  1
)

export TREE_VIEW="$(tree -C $ROOT_DIR)"
source "${TOP_DIR}/lesson_manager.sh"
