#!/bin/bash


# Timestamp for log uniqueness
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"

TARGET_SCRIPT="$1"

LOG_BASE="./.history"

if [[ ! -d "$LOG_BASE" ]]; then
    mkdir -p "$LOG_BASE"
fi

# Strip path and extension to build log names
BASE_NAME="$(basename "$TARGET_SCRIPT" .sh)"
: "${BASE_NAME:=bash}"

# File names
LOG_FILE="${LOG_BASE}/${BASE_NAME}_${TIMESTAMP}.log"
HIST_FILE="${LOG_BASE}/${BASE_NAME}_${TIMESTAMP}.history.txt"

#echo "Recording session running '$TARGET_SCRIPT'"
#echo "Log: ${LOG_BASE}/$LOG_FILE"
#echo "Command history: $HIST_FILE"

RCFILE="./profile/bashrc"
cat > ${RCFILE} <<EOF
source ~/.bashrc
cmd_hook() {
  echo "⏱️ Last command finished at $(date)"
}
export PROMPT_COMMAND=cmd_hook
export PS1="$ "
export NO_COLOR=1
unset LS_COLORS
alias ls='ls --color=never'
alias grep='grep --color=never'
echo "Type 'exit' or press Ctrl+D when finished."
echo ${C_DIR}
EOF

# Check if file exists and is executable
if [[ ! -f "$TARGET_SCRIPT" || ! -x "$TARGET_SCRIPT" ]]; then

HISTFILE="./${HIST_FILE}" \
HISTTIMEFORMAT="%F %T" \
PS1="$ " \
	script -q -c "bash --rcfile ${RCFILE}" "$LOG_FILE"
else
# Notify user
# Set up history logging
HISTFILE="./${HIST_FILE}" \
HISTTIMEFORMAT="%F %T" \
PS1="$ " \
  script -q -c "bash --rcfile ${RCFILE} $TARGET_SCRIPT" "$LOG_FILE"
fi
# Start a new shell with the target script

echo "✅ Session complete."
