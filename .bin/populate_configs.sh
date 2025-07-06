#!/bin/bash
# check if DATA_DIR from $1 is set, if not set it to /data
if [ -z "$1" ]; then
  echo "Usage: $0 <data_directory>"
  exit 1
fi
DATA_DIR="$1"
if [ -z "$DATA_DIR" ]; then
  DATA_DIR="/data"
fi
if [ -d "$DATA_DIR" ]; then
  echo "Cleaning old data directory at $DATA_DIR"
  sudo rm -rf "$DATA_DIR"
fi
# Set configuration and log directories
sudo mkdir -p "$DATA_DIR"
CONFIG_DIR="$DATA_DIR/aircraft/configurations"
LOG_DIR="$DATA_DIR/logs"

sudo mkdir -p "$CONFIG_DIR" "$LOG_DIR"

# Create nested configuration directories and files
sudo mkdir -p "$CONFIG_DIR"/{xq-67a,mq-1c,mq-9b,mq-20,mojave,mq-9}
sudo chown -R "$USER":"$USER" "$DATA_DIR"
touch "$CONFIG_DIR"/n345qr.cfg
touch "$CONFIG_DIR"/n678st.cfg
touch "$CONFIG_DIR/xq-67a"/{n223wx.cfg,index.cfg,n901uv.cfg}
touch "$CONFIG_DIR/mq-1c"/{n789ef.cfg,n101gh.cfg,index.cfg}
touch "$CONFIG_DIR/mq-9b/index.cfg"
touch "$CONFIG_DIR/mq-20"/{n234ij.cfg,n567kl.cfg,index.cfg}
touch "$CONFIG_DIR/mojave"/{n456cd.cfg,index.cfg,n123ab.cfg}
touch "$CONFIG_DIR/mq-9"/{n112op.cfg,n890mn.cfg,index.cfg}
# Set base directory
BASE_DIR="/data/aircraft/configurations"

# Create random GPS coordinate
#random_coord() {
#  echo "$(shuf -i -90.0000000000000-90.0000000000000 -n 1), $(shuf -i -180.0000000000000-180.0000000000000 -n 1), $(shuf -i 100-2000 -n 1)"
#}
random_coord() {
  lat=$(awk -v min=-90 -v max=90 'BEGIN{srand(); printf "%.6f", min + rand() * (max - min)}')
  lon=$(awk -v min=-180 -v max=180 'BEGIN{srand(); printf "%.6f", min + rand() * (max - min)}')
  alt=$(shuf -i 100-2000 -n 1)
  echo "$lat, $lon, $alt"
}

# Create random config content
generate_config() {
  local tail_number="$1"
  local mission_id="MISS-$(shuf -i 1000-9999 -n 1)"
  local objective=$(shuf -e "Patrol" "Recon" "Survey" -n 1)
  local start_time=$(printf "%02d:%02d" $(shuf -i 0-23 -n 1) $(shuf -i 0-59 -n 1))
  local duration=$(shuf -i 45-180 -n 1)
  local max_altitude=$(shuf -i 500-2000 -n 1)
  local max_speed=$(shuf -i 100-300 -n 1)
  local capacity=$(shuf -i 50-200 -n 1)
  local infrared=$(shuf -e True False -n 1)
  local frequency=$(shuf -i 24-50 -n 1)
  local encryption="AES-128"
  local log_file="/data/logs/${tail_number}_1a.log"

  cat <<EOF
[mission]
mission_id = $mission_id
objective = $objective
start_time = $start_time
duration_minutes = $duration

[drone]
tail_number = $tail_number
max_altitude = $max_altitude
max_speed = $max_speed
payload_capacity = $capacity

[camera]
resolution = 1080p
frame_rate = 60
infrared = $infrared

[communication]
frequency = $((frequency / 10)).$((frequency % 10))
encryption = $encryption

[logging]
log_level = info
log_file = $log_file

[waypoints]
waypoint_1 = $(random_coord)
waypoint_2 = $(random_coord)
waypoint_3 = $(random_coord)
waypoint_4 = $(random_coord)
waypoint_5 = $(random_coord)
EOF
}

# Main loop to find .cfg files and write config
find "$BASE_DIR" -type f -name "*.cfg" ! -name "index.cfg" | while read -r file; do
  tail_number=$(basename "$file" .cfg)
  echo "Populating $file with random config for $tail_number"
  generate_config "$tail_number" > "$file"
done
cat $(dirname "$0")/logs.tgz | (cd "$DATA_DIR"; tar xzvf -)
