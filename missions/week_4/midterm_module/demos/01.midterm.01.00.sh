#!/bin/bash -x
# mission_absolute_relative_paths.sh
# -*- coding: utf-8 -*-
export TRAINING_SHELL="1"
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"
source "$TOP_DIR/copy_data.sh"

export WORK_DIR="/data/aircraft/configurations"
export lesson_title="Midterm: File System Structure"
export lesson="$(cat<<EOS
# Lab Exercise: Filesystem, Permissions, Paths
## In this set of exercises, you will manipulate a drone configuration directory structure

EOS
)"

declare -g -a prompts=(
  "$(cat <<'EOS'
Create the directory midterm in this current directory.;
re:mkdir midterm|mkdir -p midterm;
**Objective**: Demonstrate how to create a directory.;
EOS
)
"
)

source "$TOP_DIR/quizshell.sh"
