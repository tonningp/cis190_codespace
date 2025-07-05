#!/bin/bash -x
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LOG_FILE="${LOG_BASE}/${BASE_NAME}_exercises.log"
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
export HISTFILE="${LOG_BASE}/${BASE_NAME}_exercise.history.txt"
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTTIMEFORMAT="%F %T"
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
export -f is_expected_input
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
# make render_markdown global
export -f render_markdown

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
export -f render_eval_correct

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
- $right_arrow Your input: $user_input
- $right_arrow Expected input: $expected
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
export -f render_incorrect

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

run_shell_exercise () {
    local index="$1"
    local type="$2"
    local session_log="$3"
    local history_log="$4"
    local prompt="${prompts[$index]}"
    local expected="${patterns[$index]}"
    local hint="${hints[$index]}"
    local eval="${evals[$index]}"
    export temp_script=$(mktemp)

    if [[ -n "$DISPLAY_FILE_TREE" ]]; then
    export temp_file=$(mktemp)
cat <<EOT >$temp_file
> $(emoji file_folder) Lesson files
\`\`\`text
$(tree -C "$WORK_DIR")
\`\`\`
EOT
    fi
  if [[ "$type" == "command" ]]; then
    cat > "$temp_script" <<EOF
#!/bin/bash
export HISTFILE="$history_log"
export HISTTIMEFORMAT="%F %T "
export PS1="[$BASE_NAME] $ "
touch "$HISTFILE"
history -r
cat $temp_file | fold -s -w 80 | render_markdown
wait_for_correct_input "${prompt}" "${expected}" "${hint}" "${eval}" | tee -a "$session_log"
EOF
      chmod +x "$temp_script"
      script -q -c "$temp_script" "$session_log"
  elif [[ "$type" == "shell" ]]; then
    export temp_rc=$(mktemp)
    cat > "$temp_rc" <<EOF
#!/bin/bash -x
# Lesson plan as a string
# Write the lesson to a file once, so it's accessible in all scopes
# Command check function
check_command() {
  in_list() {
      local value="\$1"; shift
      for item; do [[ "\$value" =~ \$item ]] && return 0; done
      return 1
  }
  local hash_commands=(
    '^#\ *reset'
    '^#\ *train'
    '^#\ *files'
    '^#\ *hint'
    '^#\ *instruct'
    '^#\ *skip'
    '^#\ *jump'
    '^man\ .*'
  )
  local index_file="\$HOME/.lesson_index.txt"
  local prompt_file="\$HOME/.current_prompts.txt"
  grading_log="\$(dirname \$(realpath $0))/../history/grading_${BASE_NAME}.txt"
  #local lesson_file="\$HOME/.current_lesson.txt"
  # Read index value
  local index
  index=\$(< "\$index_file")
  # First time running: initialize to 0
  if [[ "\$index" == "-1" ]]; then
    echo "0" > "\$index_file"
    return
  fi
  # Read, remove newlines, trim extra semicolons
  prompt_string=\$(cat \$prompt_file | tr -d '\n')
  # Split into array
  IFS=';' read -ra prompts <<< "\$prompt_string"
  # Extract expected command and trim whitespace
    local expected_command="\${prompts[\$((index+1))]}"
    expected_command="\$(echo \"\$expected_command\" | xargs)"  # remove leading/trailing whitespace
    local hint="\${prompts[\$((index+2))]}"
    last_command="\$(fc -ln -1 | sed 's/^[[:space:]]*//')"
    if [[ -z "\$last_command" ]]; then
      echo "No command entered yet. Please enter a command."
    elif [[ "\$last_command" =~ ^#\ *reset ]]; then
      echo "Resetting lesson..."
      echo "-1" > "\$index_file"
      echo "0" > "\$index_file"
      echo "Resetting grading log..."
      echo "" > "\$grading_log"
      index=\$(< "\$index_file")
      sed -i '/reset/d' "\$HISTFILE"
    elif [[ "\$last_command" =~ ^#\ *hint ]]; then
      if [[ -n "\$hint" ]]; then
        echo -e "$(emoji hint) Hint: \$hint"
      else
        echo "No hint available for this step."
      fi
    elif [[ "\$last_command" =~ ^#\ *instruct ]]; then
        display_lesson "\$(cat \$HOME/.current_lesson.txt)"
    elif [[ "\$last_command" == "# skip" ]]; then
        ((index+=3))
        echo "\$(date +%s):\$(( index / 3)):\$(( size_prompts / 3 )):0" >> "\$grading_log"
        echo "\$index" > "\$index_file"
    fi
    size_prompts="\${#prompts[@]}"
    if [[ "\$index" -ge "\$size_prompts" ]]; then
      echo "> 🏁 All commands completed!" | fold -s -w 80 | render_markdown return_code=0
      exit 0
    fi
    if [[ "\$expected_command" =~ ^re:.* ]]; then
      # If using regex match
      local regex="\${expected_command#re:}"
      if [[ "\$last_command" =~ \$regex ]]; then
        echo
        echo "✅ That is correct!"
        ((index+=3))
        echo "\$(date +%s):\$(( index / 3)):\$(( size_prompts / 3 )):1" >> "\$grading_log"
        echo "\$index" > "\$index_file"
      elif ! in_list "\$last_command" "\${hash_commands[@]}"; then
        echo "❌ Try again. Your last command was: \$last_command  -- Hint: '\$hint'" | fold -s -w 80 | render_markdown
      fi
    else
      # Use literal string comparison
      if [[ \$last_command != '# reset' && "\$last_command" == "\$expected_command" ]]; then
        echo
        echo "✅ That is correct!"
        ((index+=3))
        echo "\$(date +%s):\$(( index / 3)):\$(( size_prompts / 3 )):1" >> "\$grading_log"
        echo "\$index" > "\$index_file"
      elif ! in_list "\$last_command" "\${hash_commands[@]}"; then
        echo "❌ Try again. Your last command was: \$last_command  -- Hint: '\$hint'" | fold -s -w 80 | render_markdown
      fi
    fi
    echo
    echo -e "> Task \$((index/3+1)) of \$((size_prompts / 3)) \$(emoji finger_pointing_right) \${prompts[\$index]}" | fold -s -w 80 | render_markdown
    echo

}
export -f check_command
PROMPT_COMMAND=check_command

export TERM=xterm-256color
export USER=$(whoami)
export HISTFILE="$history_log"
export HISTSIZE=1000
export HISTTIMEFORMAT="%F %T "
export PS1="[$BASE_NAME] $ "
history -r
EOF
cat > "$temp_script" <<EOF
#!/bin/bash
load_lesson() {
  local lesson="\$1"
  local prompts="\$2"
  echo "\$lesson" > "\$HOME/.current_lesson.txt"
  echo "\$prompts" > "\$HOME/.current_prompts.txt"
  local prompt_file="\$HOME/.current_prompts.txt"
  echo "-1" > "\$HOME/.lesson_index.txt"
  # Read, remove newlines, trim extra semicolons
  prompt_string=\$(cat \$prompt_file | tr -d '\n')
  # Split into array
  IFS=';' read -ra prompts <<< "\$prompt_string"
  clear
  size_prompts="\${#prompts[@]}"
  cat <<EOT | fold -s -w 80 | render_markdown
  $( echo -e "$(emoji sunglasses) Student Name: ${FIRSTNAME} ${LASTNAME} (${STUDENT_ID})"
    echo -e "$lesson_title"
    echo "---"
    echo -e "$lesson"
    echo "---"
    cat "${TOP_DIR}/common_instructions.md"
    echo "---"
    echo -e "> Task 1 of \$(( size_prompts / 3 )) $(emoji finger_pointing_right) \${prompts[0]}"
    )
EOT
}
export -f load_lesson
load_lesson "$expected" "${prompts[$index]}"
exec  bash --rcfile "$temp_rc" -i
EOF
      script -q -c "bash -i $temp_script"  "$session_log"
  fi
  rm -f "$temp_script"
  rm -f "$temp_rc"
  rm -f "$temp_file"
}
export -f run_shell_exercise

run_exercises() {
    local start_index=0
    if [[ -z "$prompts" ]];then
        echo "Error: prompts array is not set."
        exit 1
    fi
    local end_index=${#prompts[@]}
    mark_time "Start of exercise ${BASE_NAME}"
    local index=$start_index
    while true; do
        if (( index > end_index-1 )); then
            break
        fi
        local session_log="$(dirname $(realpath $0))/../history/session_${BASE_NAME}_$(printf "%02d" "$index").log"
        local history_log="$(dirname $(realpath $0))/../history/history_${BASE_NAME}_$(printf "%02d" "$index").txt"
        run_shell_exercise "$index" "shell" "$session_log" "$history_log"
        #echo "exit code: $?" 
        #echo "read_return_code: $read_return_code" 
        #echo "return_code: $return_code" 
        if [[ $read_return_code =~ ^10[0-9]+$ ]]; then
            echo "read_return_code is : $read_return_code"
        elif [[ $return_code =~ ^10[0-9]+$ ]]; then
           new_index=$((return_code - 100))
           if (( new_index > 0 && new_index <= ${#prompts[@]} )); then
               index=$((new_index - 1))
             continue
           fi
        else
            echo "End of Step $((index + 1)) of ${#prompts[@]} with return code $read_return_code" >> "$session_log"
            echo "==> Step $((index + 1)) of ${#prompts[@]} completed."
        fi
        ((index++))
    done
    mark_time "End of exercise ${BASE_NAME}"
}
export -f run_exercises

grade_shell_exercise() {
    local expected="$1"
    local history_log="$2"
    if [[ -f "$history_log" ]]; then
        student_cmd=$(grep -v '^#' "$history_log" | tail -n 1 | sed 's/^[[:space:]]*//')
        if [[ "$student_cmd" == "$expected" ]]; then
            echo "1"
        else
            echo "0"
        fi
    else
        echo "0"
    fi
  }
export -f grade_shell_exercise

grade_exercises() {
    total="${#prompts[@]}"
    passed=0
    grading_log="$(dirname $(realpath $0))/../history/grading_${BASE_NAME}.txt"
    for index in "${!prompts[@]}"; do
        local history_log="$(dirname $(realpath $0))/../history/history_${BASE_NAME}_$(printf "%02d" "$index").txt"
        result=$(grade_shell_exercise ${patterns[$index]} "$history_log")
        echo "$(date +%s):$index:$result" >> $grading_log
        passed=$((passed + result))
    done
    echo "Results for Exercise - ${BASE_NAME}: $passed / $total"
}
export -f grade_exercises

export read_return_code=0
export return_code=-1
function wait_for_correct_input() {
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
        return_code=2
        return $return_code
    fi
    if [[ -z "$user_input" ]]; then
        continue
    fi
    case "$user_input" in
        exit)
            return_code=0
            return $return_code
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
        instruct)
            clear
            display_lesson "$lesson"
            continue 
            ;;
        skip)
            echo "Moving to the next step..."
            return_code=131
            return $return_code
            ;;
        jump\ *)
            target=$(echo "$user_input" | cut -d' ' -f2)
            if [[ "$target" =~ ^[0-9]+$ ]] && (( target > 0 )) && (( target <= ${#prompts[@]} )); then
                echo -e "$(emoji jump)Jumping to step $target..."
                return_code=$((100 + target))
                return $return_code
            else
              echo "Invalid step number: $target"
              continue
            fi
            ;;
        *)
          if is_expected_input "$user_input" "$expected"; then
              if [[ $_eval == 1 ]]; then
                render_eval_correct "$user_input" "$expected"
              fi
              return_code=1
              return $return_code
          else
              render_incorrect "$user_input" "$expected" "$hint"
              continue
          fi
          ;;
    esac
  done
}
export -f wait_for_correct_input

function hr() {
    echo "--------------------------------------------------------------------------------"
}
export -f hr

function mark_time() {
    local message="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "$timestamp - $message" >> "$LOG_FILE"
}
export -f mark_time

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

if [[ -n "$TRAINING_SHELL" ]]; then

  run_exercises
  #grade_exercises


else
    # This is the old way of running the training session
    # If TRAINING_SHELL is not set, run the old training session
    do_training index prompts patterns hints evals reset
fi

echo
echo "$(emoji checkered_flag) Training session complete!"
echo

