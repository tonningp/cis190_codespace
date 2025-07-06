#!/bin/bash
cat $TOP_DIR/data.tgz | (cd /;sudo tar xzf - ) || {
  echo -e "${RED}Failed to extract data.tgz. Please check if the file exists and is accessible.${NC}"
  exit 1
}
sudo chown -R "$USER:$USER" /data || {
  echo -e "${RED}Failed to change ownership of /data. Please check permissions.${NC}"
  exit 1
}
