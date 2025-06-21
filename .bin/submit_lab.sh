#!/usr/bin/env bash
if [[ -z $1 ]]; then
  echo "Usage: $0 <module_name>"
  exit 1
fi
module="$1"
export TOP_DIR="$(dirname "$(realpath "$0")")"
source "$TOP_DIR/environment.sh"
# ---- CONFIG ----
TMPDIR="/tmp/lab_submit_$RANDOM"
mkdir -p "$TMPDIR"

# ---- EXTRACT STUDENT ID ----
if [[ -f "$PROFILE_DB" ]]; then
  STUDENT_ID=$(sqlite3 "$PROFILE_DB" "SELECT id FROM students LIMIT 1;")
  FIRSTNAME=$(sqlite3 "$PROFILE_DB" "SELECT firstname FROM students LIMIT 1;")
  LASTNAME=$(sqlite3 "$PROFILE_DB" "SELECT lastname FROM students LIMIT 1;")
  if [[ -z "$STUDENT_ID" ]]; then
    echo "[!] student_id not found in $PROFILE_DB"
    exit 1
  fi
else
  echo "[!] Profile database not found at $PROFILE_DB"
  exit 1
fi
OUTFILE="${STUDENT_ID}_${FIRSTNAME}_${LASTNAME}_${module}_$(date +%Y%m%d_%H%M%S).tgz"

# ---- BUNDLE FILES ----
#echo "[*] Collecting files for $STUDENT_ID into $OUTFILE..."
date +"%a %b %d %-I:%M %p" > "${BASE_DIR}/home/.completed"
cp -r "${BASE_DIR}/home" "$TMPDIR/home" 2>/dev/null
cp -r ${LOG_BASE} "$TMPDIR/logs" 2>/dev/null
rm -r ${LOG_BASE}/* 2>/dev/null
cp -r ${MARKDOWN_DIR} "$TMPDIR/content" 2>/dev/null

hostname > "$TMPDIR/hostname.txt"

tar czf "$OUTFILE" -C "$TMPDIR" .
if [[ $? -ne 0 ]]; then
  echo "[!] Failed to create archive $OUTFILE"
  exit 1
fi

# ---- SUBMIT ----
#echo "[*] Submitting archive to $SUBMIT_URL..."
RESPONSE=$(curl -s -w "%{http_code}" -o curl_response.txt -X POST "$SUBMIT_URL" \
  -F "student_id=$STUDENT_ID" \
  -F "file=@$OUTFILE")

if [[ "$RESPONSE" == "200" ]]; then
  echo "[✓] Submission successful!"
  rm -rf "$TMPDIR" "$OUTFILE" curl_response.txt
else
  echo "[!] Submission failed (HTTP $RESPONSE)"
  echo "Response:"
  cat curl_response.txt
  echo "Your submission archive has been saved as $OUTFILE"
  rm -rf "$TMPDIR"
fi
