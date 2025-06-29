#!/bin/bash
# mission_template
# -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Understanding Hierarchical Filesystem in Drone Management"
export lesson="$(cat<<EOF

**Enhance your comprehension of the Linux filesystem structure through practical exercises for organizing surveillance drone files.**

> $(emoji open_file_folder) Efficient use of the filesystem hierarchy allows for structured expansion and manageable organization of surveillance drone files.

***This lesson focuses on:***

1. Interact with Root Directory:
   - Prompt: Use a command to list all top-level directories and files in the root directory (/).
   - Skill: Familiarize yourself with the essential components of the filesystem hierarchy's base.

2. Organize with Subdirectories:
   - Prompt: Create subdirectories within your drone project, separating configuration and log files.
   - Skill: Structure files by dedicating subdirectories to specific purposes.

3. Differentiate Ordinary Files:
   - Prompt: Recognize ordinary files within your 'drone_logs' directory.
   - Skill: Identify data files at the ends of paths, such as log files or configuration data.

4. Use Directory Files:
   - Prompt: Identify directory files and navigate through 'drone_projects' and 'drone_config'.
   - Skill: Understand directory files as points for branching paths within the hierarchy.

5. Expand the Structure:
   - Prompt: Expand your directory by adding a new subdirectory for images captured during missions.
   - Skill: Expand the filesystem structure to accommodate new categories of data.

EOF
)"

# Prepare a working environment
# need a tail number for the aircraft, follow the FAA guidelines
# # https://www.faa.gov/aircraft/registration/tail_numbers/
WORK_DIR="N4242A"
rm -rf "$WORK_DIR"
LOG_DIR="$WORK_DIR/logs"
CONFIG_DIR="$WORK_DIR/configs"
PROJECT_DIR="$WORK_DIR/projects"
IMAGE_DIR="$WORK_DIR/images"

# Create directories to practice on
mkdir -p "$WORK_DIR"
touch "$WORK_DIR/flight_log_2023_01.txt"
touch "$WORK_DIR/system_config.cfg"
touch "$WORK_DIR/daily_operation.md"
touch "$WORK_DIR/satellite_image_2023_01.jpg"

# Training items
declare -g -a prompts=(
"Use the correct command to list the contents in the work directory  \`$WORK_DIR\`."
  "We need to organize the files in the working directory: create the following directories in \`$WORK_DIR\`: \`configs\` \`logs\` \`projects\` \`images\`."
  "Identify and list ordinary files within the \`$LOG_DIR\`."
  "Recognize directory files by navigating through \`$PROJECT_DIR\` and \`$CONFIG_DIR\`."
  "Expand the directory structure by adding a \`$IMAGE_DIR\` to store images from the missions."
)

declare -g -a hints=(
  "Use \`ls /\` to view the files and directories in the CWD."
  "Create directories using \`mkdir\`, for configs, logs, projects and images \`mkdir $WORK_DIR/configs\`. Remember that you can use multiple directory names with mkdir."
  "Use \`ls $LOG_DIR\` to recognize ordinary data files at the folder's ends."
  "Navigate directories using \`cd\`, and list contents with \`ls\` to identify substructures."
  "Use \`mkdir\` to add structure; e.g., \`mkdir $IMAGE_DIR\` for drone mission images."
)

declare -g -a patterns=(
  "ls $WORK_DIR"
  "mkdir ${WORK_DIR}/configs ${WORK_DIR}/logs ${WORK_DIR}/projects ${WORK_DIR}/images"
  "ls $LOG_DIR"
  "cd $PROJECT_DIR && cd $CONFIG_DIR"
  "mkdir $IMAGE_DIR"
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
