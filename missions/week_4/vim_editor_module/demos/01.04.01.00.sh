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
- You will practice using the vimtutor and a file called tutorfile.txt.
- Within the file, you will find instructions to help you learn vim.
EOS
)"
export step_size=3
declare -g -a prompts=(
"$(cat <<'EOS'
\`Starting vimtutor\`@@
- Start the vimtutor application and the tutorial by entering \`vimtutor\`.@@
- Follow the instructions in the file, by completing Lesson 1.@@
- Save the file, as directed, to vimtutor.txt as you will need it later.;
vimtutor;
Follow the instructions in the tutorial to learn about Vim's basic commands and features.;

\`Editing your new file\`@@
- You should have created the file \`vimtutor.txt\` in the previous step.@@
- If you didn't then start vimtutor again and save the file as \`vimtutor.txt\`.@@
- The video talked about how to save a file in vim, so you should know how to do this.@@
- Remember it involves pressing the \`Esc\` key, then typing \`:w! vimtutor.txt\` to save the file.@@
- Restart the vim application and your file with \`vim vimtutor.txt\`.@@
- Start with Lesson 2 and complete the tutorial.@@
- Type the \`exit\` command to leave the shell when you are have completed the tutorial.;
vim vimtutor.txt;
Just follow the instructions in the tutorial to learn about Vim's basic commands and features.;
EOS
)
"
)

source "$TOP_DIR/lesson_manager.sh"
