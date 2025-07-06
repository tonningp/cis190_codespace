#!/bin/bash

LOG_DIR="./logs/$LESSON_ID"
mkdir -p "$LOG_DIR"

run_shell_exercise() {
  local index="$1"
  local prompt="${EXERCISE_PROMPTS[$index]}"
  local expected="${EXPECTED_COMMANDS[$index]}"
  local session_log="$LOG_DIR/session_$(printf "%02d" "$index").log"
  local history_log="$LOG_DIR/history_$(printf "%02d" "$index").txt"
  local temp_script
  temp_script=$(mktemp)

  cat > "$temp_script" <<EOF
#!/bin/bash
export HISTFILE="$PWD/$history_log"
export HISTTIMEFORMAT="%F %T "
export PS1="[$LESSON_ID] > "
touch "\$HISTFILE"
history -r

echo "🧪 Exercise $((index+1)): $prompt"

while true; do
  read -ep "\$PS1" cmd
  history -s "\$cmd"
  history -a
  case "\$cmd" in
    exit|quit)
      echo "Exiting the exercise."
      exit 0
      ;;
    skip)
      echo "Skipping this exercise."
      break
      ;;
    help|--help|-h)
      echo "Available commands:"
      echo "  exit, quit - Exit the exercise"
      echo "  skip - Skip to the next exercise"
      echo "  help, --help, -h - Show this help message"
      echo "  <any command> - Execute the command and log it"
      ;;
    "$expected")
      echo "✅ Correct!"
      eval "\$cmd"
      break
      ;;
    *)
      echo "❌ Try again."
      ;;
  esac
done
EOF
  chmod +x "$temp_script"
  script -q -c "$temp_script" "$session_log"
  rm -f "$temp_script"
}

run_all_exercises() {
  for i in "${!EXERCISE_PROMPTS[@]}"; do
    run_shell_exercise "$i"
  done
  echo -e "\n🎉 Lesson complete!"
}

run_all_exercises
