#!/bin/bash
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LOG_FILE="${LOG_BASE}/${BASE_NAME}_exercises.log"
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
export HISTFILE="${LOG_BASE}/${BASE_NAME}_exercise.history.txt"
export HISTSIZE=1000
export HISTFILESIZE=2000
HISTTIMEFORMAT="%F %T"
export lesson_manager="$TOP_DIR/lesson_manager.sh"

is_expected_input() {
  local input="$1"
  local expected_set="$2"

  IFS='@@' read -ra EXPECTED_ARRAY <<< "$expected_set"
  for expected in "${EXPECTED_ARRAY[@]}"; do
    if [[ "$expected" =~ ^re:(.*) ]]; then
      pattern="${BASH_REMATCH[1]}"
      if [[ "$input" =~ $pattern ]]; then
        return 0
      fi
    else
      if [[ "$input" == "$expected" ]]; then
        return 0
      fi
    fi
  done
  return 1
}

render_markdown() {
  python3 -c "
from rich.console import Console
from rich.markdown import Markdown
import sys

md = Markdown(sys.stdin.read())
console = Console(force_terminal=True, color_system='truecolor')
console.print(md)
"
}

render_eval_correct() {
  local user_input="$1"
  local expected="$2"
  local evaled="$(eval "$user_input")"
  expected=$(echo "$expected" | sed 's/^re://; s/^\[\(.*\)\]$/\1/; s/^\(.*\)$/\1/')
  #$(emoji arrow_right) Expected: $expected
  if [[ -n "$evaled" ]]; then
cat <<EOS | fold -s -w 80 | render_markdown
> $(emoji lightbulb) Your input evaluates to:
\`\`\`text
$evaled
\`\`\`
EOS
  fi
cat <<EOS | fold -s -w 80 | render_markdown
---
\`\`\`
$(emoji checkmark) Correct!
    $(emoji arrow_right) Your input: $user_input
\`\`\`
---
EOS
}

render_incorrect() {
  local user_input="$1"
  local expected="$2"
  local hint="$3"
  local right_arrow=$(emoji right_arrow)
  local crossmark=$(emoji crossmark)

  # remove regular expression prefix and symbols if they exist
  # e.g. re:^[0-9]+$ -> ^[0-9]+$ in expected
  expected=$(echo "$expected" | sed 's/^re://; s/^\[\(.*\)\]$/\1/; s/^\(.*\)$/\1/')
cat <<EOF | fold -s -w 80 | render_markdown
> $crossmark Incorrect. Try again.
- $right_arrow Your input: **$user_input**
- $right_arrow Expected input: ***$expected***
$(if [[ -n "$hint" ]]; then
    echo "- $right_arrow Hint: $hint"
fi
)

> Your input evaluates to:
\`\`\`text
$(
  if [[ $_eval == 1 ]]; then
    tmp_err=$(mktemp)
    output=$(eval "$user_input" 2>"$tmp_err")
    status=$?
    if [[ $status -ne 0 ]]; then
        echo -e "- $(emoji warning) Evaluation failed:"
        escaped=$(printf '%s\n' "$lesson_manager" | sed 's/\//\\\//g')
        cat "$tmp_err" | sed "s/$escaped://" | sed 's/line [0-9]*://g'
    elif [[ -n "$output" ]]; then
        echo "$output"
    fi
    rm -f "$tmp_err"
  elif [[ $(echo $_eval | cut -d@ -f1) == 2 ]]; then
    render_eval "$(echo $_eval | cut -d@ -f2)"
  fi
)
\`\`\`
EOF
}

if [[ -f "$TOP_DIR/requirements.txt" ]]; then 
    echo -e "  $(emoji gear) $(bright_cyan 'Setting up lesson environment, please wait...')"
    if [[ ! -d "$TOP_DIR/venv" ]]; then
        python3 -m venv "$TOP_DIR/venv"
    fi
    source "$TOP_DIR/venv/bin/activate"
    pip -q install --upgrade pip
    pip -q install -r "$TOP_DIR/requirements.txt"
fi
source "$TOP_DIR/environment.sh"

function display_lesson()  {
    clear
    cat <<EOS | fold -s -w 80 | render_markdown
# $(emoji sunglasses) Student Name: ${FIRSTNAME} ${LASTNAME} (${STUDENT_ID})
### Title: \`${lesson_title}\` (Lesson Id: ${BASE_NAME})
---
$(echo "$1";echo;echo "---")
$(if [[ -n "$TREE_VIEW" ]]; then
cat <<EOT
> $(emoji book) Lesson files 
\`\`\`text 
$TREE_VIEW
\`\`\`
EOT
    fi
)
EOS
}

function wait_for_correct_input() {
  local return_code=-1
  local prompt="$1"
  local expected="$2"
  local hint="$3"
  local _eval="$4"

  local user_input

  while true; do
    cat <<EOF | fold -s -w 80 | render_markdown
> $(emoji finger_pointing_right) ***${prompt}***
---
EOF
    set -o vi
    read -e -p "$ " user_input
    read_return_code=$?
    if [[ -n "$user_input" ]]; then
        history -s "$user_input"
        history -w $HISTFILE
    fi
    if [[ $read_return_code -ne 0 ]]; then
        return 2
    fi
    if [[ -z "$user_input" ]]; then
        continue
    fi
    case "$user_input" in
        exit)
            return 0
            ;;
        train)
            bash --rcfile "$RCFILE"
            continue
            ;;
        files)
            if [[ -n "$TREE_VIEW" ]]; then
                echo -e "$(emoji book) Lesson files:\n$TREE_VIEW"
            else
                echo "No files available for this lesson."
            fi
            continue
            ;;
        bash\ *| sh\ *| zsh\ *| fish\ *)
            echo "Ignoring shell command: $user_input"
            continue
            ;;
        clear)
            clear
            continue
            ;;
        hint)
            if [[ -n "$hint" ]]; then
                echo -e "$(emoji hint) Hint: $hint"
            else
                echo "No hint available for this step."
            fi
            continue
            ;;
        reset_lesson|reset_to\ *)
            echo "Resetting lesson..."
            if [[ $user_input == "reset_lesson" ]]; then
                :
            else
                start_index=$(echo "$user_input" | cut -d' ' -f2)
                #subtract 1 to convert to zero-based index
                # check if start_index is greater than size of prompts
                if [[ "$start_index" =~ ^[0-9]+$ ]] && (( start_index > 0 )); then
                    export start_index=$((start_index - 1))
                else
                    export start_index=0
                fi
                prompt_length=${#prompts[@]}
                if [[ $start_index =~ ^[0-9]+$ ]] && (( start_index > (prompt_length-1) )); then
                    export start_index=$((prompt_length - 1))
                fi

            fi
                exec "$0"
            ;;
        \!*)
            history_command=$(echo "$user_input" | cut -c 2-)
            if [[ -n "$history_command" ]]; then
                eval "$history_command"
            else
                echo "No command specified after '!'"
            fi
            continue
            ;;
        \$\(\))
            user_input=$(eval "${user_input:1:-1}")
            echo "Command substitution result: $user_input"
            continue
            ;;
        \#* | \#\#* | \#\#\#*)
            echo "Ignoring comment: $user_input"
            continue
            ;;
        instruct)
            clear
            display_lesson "$lesson"
            continue 
            ;;
        skip)
            echo "Moving to the next step..."
            return 131
            ;;
        jump\ *)
            target=$(echo "$user_input" | cut -d' ' -f2)
            if [[ "$target" =~ ^[0-9]+$ ]] && (( target > 0 )) && (( target <= ${#prompts[@]} )); then
                echo -e "$(emoji jump)Jumping to step $target..."
                return $((100 + target))
            else
              echo "Invalid step number: $target"
              continue
            fi
            ;;
        *)
          #echo "DEBUG: User input: $user_input"
          #echo "DEBUG: Expected input: $expected"
          #pause
          if is_expected_input "$user_input" "$expected"; then
              if [[ $_eval == 1 ]]; then
                render_eval_correct "$user_input" "$expected"
              fi
              return 1
          else
              render_incorrect "$user_input" "$expected" "$hint"
              continue
          fi
          ;;
    esac
  done
}

function hr() {
    echo "--------------------------------------------------------------------------------"
}

function mark_time() {
    local message="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "$timestamp - $message" >> "$LOG_FILE"
}

function do_training() {
    local START_INDEX=$1
    declare -n PROMPTS=$2
    declare -n PATTERNS=$3
    declare -n HINTS=$4
    declare -n EVALS=$5
    declare -n RESET=$6
    if [[ -z "$PROMPTS" || -z "$PATTERNS" || -z "$HINTS" || -z "$EVALS" ]]; then
        echo "Error: One or more required arrays are empty."
        exit 1
    fi
    #START_INDEX=0
    hr >> "$LOG_FILE"
    mark_time "Start of Lesson ${BASE_NAME}"
    display_lesson "$lesson" | tee -a "$LOG_FILE"

    end_index=${#PROMPTS[@]}
    i=$START_INDEX
    while true; do
        if (( i > end_index-1 )); then
            break
        fi
        history -r $HISTFILE
        echo "Start: Step $((i + 1)) of ${#PROMPTS[@]} for topic $BASE_NAME" >> "$LOG_FILE"
        echo -e "***$(emoji directhit) Step $((i + 1)) of ${#PROMPTS[@]}***       \`Topic: ${BASE_NAME}\`" | render_markdown
        prompt="${PROMPTS[$i]}"
        pattern="${PATTERNS[$i]}"
        hint="${HINTS[$i]}"
        _eval="${EVALS[$i]}"
        #echo "DEBUG: pattern: $pattern"
        #pause
        wait_for_correct_input "${prompt}" "${pattern}" "${hint}" "${_eval}" | tee -a "$LOG_FILE"
        return_code=${PIPESTATUS[0]}
        if [[ $return_code =~ ^10[0-9]+$ ]]; then
            :
        else
            echo "🏁 End of Step $((i + 1)) of ${#PROMPTS[@]} with return code $return_code" >> "$LOG_FILE"
            echo "==> Step $((i + 1)) of ${#PROMPTS[@]} completed."
        fi
        if [[ $return_code == 0 || $return_code == 2 ]]; then
           break
        elif [[ $return_code =~ ^10[0-9]+$ ]]; then
           new_index=$((return_code - 100))
           if (( new_index > 0 && new_index <= ${#PROMPTS[@]} )); then
               i=$((new_index - 1))
             continue
           fi
        fi
        ((i++))
    done
    mark_time "End of Lesson ${BASE_NAME}"
    hr  >> "$LOG_FILE"
}

if [[ -z "$lesson" ]]; then
    echo "Error: lesson is not set."
    exit 1
fi
# get index of the lesson --index=<number> in $1
if [[ -n $start_index && $start_index =~ ^[0-9]+$ ]]; then
    index="$start_index"
    if (( index < 0 )); then
        echo "Error: Index must be a non-negative integer."
        exit 1
    fi
else
    index=0
fi
# check if reset array is set if not set it to empty array
if [[ -z "$reset" ]]; then
    reset=()
fi

do_training index prompts patterns hints evals reset

echo
echo "$(emoji checkered_flag) Training session complete!"
echo

if [[ -n "$TRAINING_SHELL" ]]; then
    exec bash --rcfile "$RCFILE"
fi
