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

1. Interact with a directory:
   - Prompt: Use a command to list directories and files in a given directory.
   - Skill: Familiarize yourself with the essential components of the filesystem hierarchy's base.

1. Organize with Subdirectories:
   - Prompt: Create subdirectories within a directory, separating configuration and log files.
   - Skill: Structure files by dedicating subdirectories to specific purposes.

1. Differentiate Ordinary Files:
   - Prompt: Recognize ordinary files within the \`logs\` directory.
   - Skill: Identify data files at the ends of paths, such as log files or configuration data.

1. Expanding the Directory Structure:
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
touch "$WORK_DIR/flight_log_2023_01.log"
touch "$WORK_DIR/flight_log_2023_01_notes.txt"
touch "$WORK_DIR/system_config.cfg"
touch "$WORK_DIR/daily_operation.md"
touch "$WORK_DIR/satellite_image_2023_01.jpg"

# Training items
declare -g -a prompts=(
# 0
"Use the correct command to list the contents in the work directory  \`$WORK_DIR\`"
# 1
  "We need to organize the files in the working directory: create the following directories in \`$WORK_DIR\`: \`configs\` \`logs\` \`projects\`"
# 2
  "Move files with extension  \`.log\` to the \`$LOG_DIR\` directory."
# 3
  "List details of files within the \`$LOG_DIR\` directory."
# 4
  "Move files with extensions \`.cfg\` to the \`$CONFIG_DIR\` directory  and \`.md\` to the \`$PROJECT_DIR\` directory.  Pay attention to the file extensions and the directory names. You will need to perform this on one line using \`&&\` to chain the commands."
# 5
  "Expand the directory structure by adding a \`$IMAGE_DIR\` to store images from the missions."
# 6
"Move the image file \`$WORK_DIR/satellite_image_2023_01.jpg\` to the \`$IMAGE_DIR\` directory."
# 7
  "List directory files in the \`$IMAGE_DIR\`."
)

declare -g -a hints=(
# 0
  "Use \`ls $WORK_DIR\` to view the files and directories."
# 1
  "Create directories using \`mkdir\`, for configs, logs, projects and images \`mkdir $WORK_DIR/configs\`. Remember that you can use multiple directory names with mkdir."
# 2
  "Move files to the logs directory using \`mv\`,  \`mv $WORK_DIR/*.txt $LOG_DIR\`.  Pay attention to the file extensions and the directory names."
# 3
  "List contents with \`ls\` to identify files and view a long listing."
# 4
"Use \`mv\` to move files with specific extensions to their respective directories, e.g., \`mv $WORK_DIR/*.cfg $CONFIG_DIR && mv $WORK_DIR/*.md $PROJECT_DIR\`.  Pay attention to the file extensions and the directory names."
# 5
"Create a new directory for images using \`mkdir $IMAGE_DIR\`. This will help in organizing the images captured during missions."
# 6
"Use \`mv $WORK_DIR/satellite_image_2023_01.jpg $IMAGE_DIR\` to move the image file to the images directory.  Pay attention to the file name and the directory name."
# 7
"Use \`ls $IMAGE_DIR\` to list the contents of the images directory."
)

declare -g -a patterns=(
# 0: List contents in the work directory
"re:^ls +${WORK_DIR}/?$"
# 1: Create subdirectories
"re:^mkdir +(-p +)?${WORK_DIR}/(configs|logs|projects)( +${WORK_DIR}/(configs|logs|projects)){2}$\
@@re:^mkdir +(-p +)?${WORK_DIR}/\{configs,logs,projects\}$"
# 2: Move .log files to logs/
"re:^mv +${WORK_DIR}/\*\.log +${LOG_DIR}/?$"
# 3: List ordinary files in logs/
"re:^ls +${LOG_DIR}/?$"
# 4: Move .cfg and .md files to their respective directories in one line
"re:^mv +${WORK_DIR}/\*\.cfg +${CONFIG_DIR} *&& *mv +${WORK_DIR}/\*\.md +${PROJECT_DIR}$"
# 5: Make the images directory
"re:^mkdir +(-p +)?${IMAGE_DIR}/?$"
# 6: Move the image file to the images directory
"re:^mv +${WORK_DIR}/satellite_image_2023_01\.jpg +${IMAGE_DIR}/?$"
# 7: List files in the images directory
"re:^ls +${IMAGE_DIR}/?$"
)

declare -g -a evals=(
  1
  1
  1
  1
  1
  1
  1
)

declare -g -a reset=(
# 0
""
# 1
"rmdir {configs,logs,projects}"
# 2
""
# 3
""
# 4
""
# "rm -f ${CONFIG_DIR}/*.cfg ${PROJECT_DIR}/*.md"
# 5
""
# "rmdir $IMAGE_DIR"
# 6
""
# ""
)

export TREE_VIEW="$(tree -C $WORK_DIR)"
source "${TOP_DIR}/lesson_manager.sh"
