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
- You will learn the basics of the vim editor.
- You will practice using the vim and a file called tutorfile.txt.
- Within the file, you will find instructions to help you learn vim.
EOS
)"
export tutor_file="tutorfile.txt"
cp $TOP_DIR/practice $tutor_file
chmod -w $tutor_file
export step_size=3
declare -g -a prompts=(
"$(cat <<'EOS'
\`Editing an existing file\`@@
- Start the vim application and the tutorial file with \`vim ${tutor_file}\`.@@
- Follow the instructions in the file, by completing Lesson 1.;
vim tutorfile.txt;
Follow the instructions in the tutorial to learn about Vim's basic commands and features.;
\`Editing your new file\`@@
- Restart the vim application and your file with \`vim myfile.txt\`.@@
- Start with Lesson 2 and complete the tutorial.@@
- Type the \`exit\` command to leave the shell when you are have completed the tutorial.;
vim myfile.txt;
Just follow the instructions in the tutorial to learn about Vim's basic commands and features.;
EOS
)
"
)

source "$TOP_DIR/lesson_manager.sh"
