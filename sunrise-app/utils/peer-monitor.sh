#!/bin/bash

TARGET_PEERS=(
  "13.212.253.1:26656" # peer (IP address:port)
  "44.213.62.82:26656"  
  "44.222.102.202:26656" 
  "18.197.226.58:26656"
  "13.52.180.217:26656"
  "13.208.246.16:26656"
)
TARGET_PORT="26656"
DAEMON_NAME="cosmovisor"      # daemon name

while true; do
  down_count=0
  for peer in "${TARGET_PEERS[@]}"; do
    if ! netstat -an | grep ESTABLISHED | grep "${peer}"; then
      echo "$(date) Connection to ${peer} is down."
      down_count=$((down_count + 1))
    fi
  done

  queue_size=0  # init
    for peer in "${TARGET_PEERS[@]}"; do
       peer_queue_size=$(ss -nt state ESTABLISHED "( dport = :${TARGET_PORT} or sport = :${TARGET_PORT} )" | grep "${peer}" | awk '{print $1}' | sed 's/.*recv-q://')
      if [ -n "${peer_queue_size}" ]; then
           queue_size=$((queue_size + peer_queue_size))
      fi
  done

  if [ ${queue_size} -gt 10000 ]; then 
      echo "$(date) Receive queue size is over 10000."
      down_count=$((down_count + 1))
  fi

  if [ ${down_count} -ge 4 ]; then
    echo "$(date) 4 or more connections are down. Restarting ${DAEMON_NAME}..."
    sudo systemctl restart ${DAEMON_NAME}
  fi

  sleep 60  # every 60sec
done