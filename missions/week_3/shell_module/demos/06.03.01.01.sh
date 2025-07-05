#!/bin/bash
# mission_template
# -*- coding: utf-8 -*-
export TRAINING_SHELL="1"
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Job Control"
export lesson="$(cat<<EOF
# Demonstration Training: Job Control
Job control allows you to manage processes in the shell, including running them in the background or bringing them to the foreground.
EOF
)"

# Prepare a working environment
ROOT_DIR='working'
UTILITIES_DIR="$ROOT_DIR/utilities"
CONFIG_DIR="$ROOT_DIR/config"
LOG_DIR="$ROOT_DIR/logs"
mkdir -p "$CONFIG_DIR" "$LOG_DIR" "$UTILITIES_DIR"
# Create some example files
cat <<EOF > "$UTILITIES_DIR/utility.sh"
#!/bin/bash
# A simple utility script that simulates a long-running process
echo "Utility script started. PID: \$\$"
while true; do
    echo "Utility script is running..."
    sleep 5 
done
echo "Utility script finished."
EOF
chmod +x "$UTILITIES_DIR/utility.sh"
# Training items
declare -g -a prompts=(
"$(cat <<EOT
Enter the command to display the current working directory.;
pwd;
The current working directory should be $(pwd).;

Enter the command to start the utility script in the background.;
$UTILITIES_DIR/utility.sh &;
The utility script should start running in the background, and you should see its PID in the output.;

Enter the command to display the jobs running in the background.;
jobs;
You should see the utility script listed as a background job with its PID.;

Enter the command to bring the utility script to the foreground.;
fg %1;
You should see the output of the utility script in the foreground, and it will continue running until you stop it.;

Enter the command to stop the utility script gracefully.;
kill \$!;
You should see a message indicating that the utility script has been stopped.;

EOT
)"

)

export TREE_VIEW="$(tree -C $ROOT_DIR)"
source "${TOP_DIR}/lesson_manager.sh"
