#!/bin/bash -x
# mission_absolute_relative_paths.sh
# -*- coding: utf-8 -*-
export TRAINING_SHELL="1"
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"
source "$TOP_DIR/copy_data.sh"

export lesson_title="The bash shell"
export lesson="$(cat<<EOS
# Lab Exercise: The bash shell
EOS
)"
export no_grade_exercises=1
export step_size=3
declare -g -a prompts=(
"$(cat <<'EOS'
\`The bash shell\`@@
Type ps;
ps;
You should see your shell running.;

\`The results of ps\`@@
\`ps\` tells you what running processes you have in@@
your current session, you can see that bash is one of them@@
Now type \`ps aux\`;
ps aux;
You should see all processes.;

\`The results of ps aux\`@@
\`ps aux\` tells you all processes in the current container@@
Now type \`exit\`;
exit;
You should exit.;

EOS
)
"
)

source "$TOP_DIR/lesson_manager.sh"
