#!/bin/bash -x
# mission_template
# -*- coding: utf-8 -*-
export TRAINING_SHELL="1"
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"
# Prepare a working environment
source "$TOP_DIR/copy_data.sh"

export WORK_DIR="/data/aircraft/configurations"
export lesson_title="Wildcards in the Shell"
export lesson="$(cat<<EOS
# Demonstration Training: Wildcards
In this lesson, you will demonstrate how to use wildcards in the shell to match filenames and directories.
EOS
)"


declare -g -a prompts=(
# format is the following
# prompt text;
# command to run;
# optional comment or hint;
  "$(cat <<EOT
Navigate to the working directory ${WORK_DIR}.;
re:cd ${WORK_DIR}|cd ${WORK_DIR}/;
Use 'cd' to change to the working directory defined by the WORK_DIR variable.

Print the current working directory to confirm your location.;
pwd;
Use `pwd` to print the current working directory.

List all files in the mq-1c directory ending in .cfg.;
ls /data/aircraft/configurations/mq-1c/*.cfg;
Use '*' to match any characters before '.cfg'.

List all index.cfg files in all subdirectories of configurations.;
ls /data/aircraft/configurations/*/index.cfg;
Use '*' to match any subdirectory, then specify the file name.

Copy all .cfg files in mq-20 to a new directory called backup.;
cp /data/aircraft/configurations/mq-20/*.cfg backup/;
Use '*' to match all '.cfg' files, and specify the destination directory.

Count the number of '.cfg' files that begin with 'n1' in any subdirectory of configurations.;
ls /data/aircraft/configurations/*/n1*.cfg | wc -l;
Use 'n1*' to match filenames starting with 'n1', then pipe to 'wc -l'.

Use grep to search for the word 'Patrol' in all .cfg files in mq-9.;
grep 'Patrol' /data/aircraft/configurations/mq-9/*.cfg;
Use '*' to expand all '.cfg' files for grep to search.
EOT
)"

)

export DISPLAY_FILE_TREE="1"
source "${TOP_DIR}/lesson_manager.sh"
