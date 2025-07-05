#!/bin/bash
# mission_template
# -*- coding: utf-8 -*-
export TRAINING_SHELL="1"
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Title Here"
export lesson="$(cat<<EOF
# TBD ${0}

EOF
)"

# Prepare a working environment
ROOT_DIR='working_dir'
CONFIG_DIR="$ROOT_DIR/config"
LOG_DIR="$ROOT_DIR/logs"
mkdir -p "$CONFIG_DIR" "$LOG_DIR"

# Training items
declare -g -a prompts=(
  "TBD - prompt ls to test"
)

declare -g -a hints=(
  "prompt hint"
)

declare -g -a patterns=(
  "ls -l"
)

declare -g -a evals=(
  1
)
export TREE_VIEW="$(tree -C $ROOT_DIR)"
source "${TOP_DIR}/lesson_manager.sh"
