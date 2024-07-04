#!/bin/bash

TARGET_PEERS=(
  "44.213.62.82:26656"  # peer (IP address:port)
  "44.222.102.202:26656" 
  "18.197.226.58:26656"
  "13.52.180.217:26656"
  "13.208.246.16:26656"
)
DAEMON_NAME="cosmovisor"      # daemon name

while true; do
  down_count=0
  for peer in "${TARGET_PEERS[@]}"; do
    if ! netstat -an | grep ESTABLISHED | grep "${peer}"; then
      echo "$(date) Connection to ${peer} is down."
      down_count=$((down_count + 1))
    fi
  done

  if [ ${down_count} -ge 2 ]; then
    echo "$(date) 2 or more connections are down. Restarting ${DAEMON_NAME}..."
    sudo systemctl restart ${DAEMON_NAME}
  fi

  sleep 60  # every 60sec
done