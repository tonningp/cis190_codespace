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
export lesson_title="Redirecting Output and Input"
export lesson="$(cat<<EOS
# Demonstration Training: Redirecting Output and Input
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
Use 'cd' to change to the working directory defined by the WORK_DIR variable.;

Use the **find** command to find the file n101gh.cfg in the working directory.;
find . -name n101gh.cfg;
Use 'find' to search for the file n101gh.cfg in the current directory.;

Redirect the contents of n101gh.cfg to a new file called summary.txt.  You can use eithter an absolute or a relative path.;
re:cat /data/aircraft/configurations/mq-1c/n101gh.cfg > summary.txt|cat mq-1c/n101gh.cfg > summary.txt;
Use '>' to write output to a new file, replacing it if it exists.;

Navigate to the /data/logs directory using an absolute path.;
cd /data/logs;
Use 'cd' with an absolute path starting with '/data/logs'.;

Print the current working directory to confirm your location.;
pwd;
Use 'pwd' to print the current working directory.;

Append the line '# Mission complete' to the file flight.log.;
echo '# Mission complete' >> flight.log;
Use '>>' to append to an existing file without overwriting it.;

Use 'wc -l' to count the number of lines in n234ij.cfg by redirecting input from the file.  You can look up what wc does if you are not familiar with it.  Enter 'man wc';
wc -l < /data/aircraft/configurations/mq-20/n234ij.cfg;
Use '<' to redirect the file into the stdin of 'wc -l'.;

Use cat and grep to find the payload line in n123ab.cfg using a pipe.;
cat /data/aircraft/configurations/mojave/n123ab.cfg | grep payload;
Use '|' to send the output of **cat** into **grep**.;
EOT
)"

)


source "${TOP_DIR}/lesson_manager.sh"
