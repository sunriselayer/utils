#!/bin/bash
# // This script checks the status of a sunrise node and sends alerts to Slack.
# //
# // Overview:
# // It performs three main checks:
# // 1. If the 'sunrised status' command fails.
# // 2. If the latest block time from the status is older than 1 hour.
# // 3. If the validator has become unbonded.
# //
# // Specifications:
# // - Node name and Slack details (webhook, token, channel) are configurable.
# // - It uses 'jq' to parse JSON responses from the sunrised command.
# // - It sends a warning message to a specified Slack channel upon detecting an issue.
# //
# // Limitations:
# // - Assumes 'jq' and 'curl' are installed and in the system's PATH.
# // - Assumes GNU 'date' for parsing the ISO 8601 timestamp.
# // - Slack token and other sensitive data are stored in plain text.

## Cronjob example:
## 0 * * * * sh /home/ubuntu/utils/sunrise-app/setup_node/check-node-status.sh

# Node Name
NODE=dawn-1-rpc-aws-ja

# Slack Incoming Webhook URL
SLACK_WEBHOOK_URL=https://slack.com/api/chat.postMessage
TOKEN=
CHANNEL=#dev-node

# Command
COMMAND="/home/ubuntu/go/bin/sunrised status"

# Execute command and capture output. 'sunrised status' outputs to stderr.
STATUS_OUTPUT=$($COMMAND 2>&1)

# Error Code
EXIT_CODE=$?

# Create Message
if [ $EXIT_CODE -eq 0 ]; then
  # Check if the latest block time is older than 1 hour
  LATEST_BLOCK_TIME=$(echo "$STATUS_OUTPUT" | jq -r '.sync_info.latest_block_time')
  LATEST_BLOCK_TIMESTAMP=$(date -d "$LATEST_BLOCK_TIME" +%s)
  CURRENT_TIMESTAMP=$(date +%s)
  
  TIME_DIFF=$((CURRENT_TIMESTAMP - LATEST_BLOCK_TIMESTAMP))
  
  if [ $TIME_DIFF -gt 3600 ]; then
    MESSAGE="WARNING: ${NODE} latest_block_time is older than 1 hour (${TIME_DIFF} seconds ago)."
    # Send to Slack
    curl -s -X POST "${SLACK_WEBHOOK_URL}" \
      -d "token=${TOKEN}" \
      -d "channel=${CHANNEL}" \
      -d "text=${MESSAGE}"
  fi

  # Check if validator is unbonded
  response=$(/home/ubuntu/go/bin/sunrised q staking validator sunrisevaloper1tl3pd2spm33dphsry6apmvflpdpcak6hwsr22t -o json)
  if [ $? -eq 0 ]; then
    status=$(echo "$response" | jq -r '.status')
    if [ "$status" = "BOND_STATUS_UNBONDED" ]; then
      MESSAGE="WARNING: ${NODE} is unbonded!."
      # Send to Slack
      curl -s -X POST "${SLACK_WEBHOOK_URL}" \
        -d "token=${TOKEN}" \
        -d "channel=${CHANNEL}" \
        -d "text=${MESSAGE}"
    fi
  fi
  
else
  MESSAGE="WARNING: ${NODE} is not working due to error(code ${EXIT_CODE}). Output: ${STATUS_OUTPUT}"
  # Send to Slack
  curl -s -X POST "${SLACK_WEBHOOK_URL}" \
    -d "token=${TOKEN}" \
    -d "channel=${CHANNEL}" \
    -d "text=${MESSAGE}"
fi
