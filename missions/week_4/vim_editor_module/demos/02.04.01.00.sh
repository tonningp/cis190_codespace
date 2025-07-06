#!/bin/bash -x
# mission_absolute_relative_paths.sh
# -*- coding: utf-8 -*-
export TRAINING_SHELL="1"
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"
source "$TOP_DIR/copy_data.sh"

export lesson_title="The vimtutor application"
export lesson="$(cat<<EOS
# Lab Exercise: Vimtutor Application
In this lab
- You will learn how to use the vimtutor application
- vimtutor is a built-in tutorial for the Vim text editor. 
- You will become familiar with the basic commands and features of Vim.
EOS
)"

declare -g -a prompts=(
  "$(cat <<'EOS'
Start the vimtutor application by entering the vimtutor command in your terminal.;
vimtutor;
Just follow the instructions in the tutorial to learn about Vim's basic commands and features.
EOS
)
"
)

source "$TOP_DIR/lesson_manager.sh"
