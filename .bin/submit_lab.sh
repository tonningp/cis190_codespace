#!/usr/bin/env bash
export TOP_DIR="$(dirname "$(realpath "$0")")"
source "$TOP_DIR/environment.sh"
# ---- CONFIG ----
SUBMIT_URL="https://cis.vvc.edu/submit_assignment/submit-file"
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
base_module_name=$(echo $module | sed 's/[0-9]*.\.[0-9]*\.//g')
OUTFILE="${STUDENT_ID}_${FIRSTNAME}_${LASTNAME}_${base_module_name}_$(date +%Y%m%d_%H%M%S).tgz"

# ---- BUNDLE FILES ----
#echo "[*] Collecting files for $STUDENT_ID into $OUTFILE..."

cp -r ${LOG_BASE}/* "$TMPDIR/" 2>/dev/null
cp -r ${MARKDOWN_DIR}/* "$TMPDIR/" 2>/dev/null

hostname > "$TMPDIR/hostname.txt"
date > "$TMPDIR/submitted_at.txt"

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
