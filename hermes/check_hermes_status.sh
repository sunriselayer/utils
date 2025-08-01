#!/bin/bash

# Slack Incoming Webhook URL
SLACK_WEBHOOK_URL="https://slack.com/api/chat.postMessage"
TOKEN=""
CHANNEL="#dev-node"
NODE_NAME="sunrise-hermes-relayer-b-aws"
SERVICE_NAME="hermes.service"
TIME_WINDOW="5 minutes ago"

# Function to send Slack notification
send_slack_notification() {
  MESSAGE=$1
  curl -s -X POST "${SLACK_WEBHOOK_URL}" \
    -d "token=${TOKEN}" \
    -d "channel=${CHANNEL}" \
    -d "text=${MESSAGE}" > /dev/null
}

# Check if hermes.service is active
if ! systemctl is-active --quiet ${SERVICE_NAME}; then
  SERVICE_STATUS=$(systemctl status ${SERVICE_NAME} | cat)
  MESSAGE="CRITICAL: ${NODE_NAME} service (${SERVICE_NAME}) is not running. Status:\n\`\`\`${SERVICE_STATUS}\`\`\`"
  send_slack_notification "${MESSAGE}"
  exit 1
fi

# Check for ERROR logs in the last 5 minutes
ERROR_LOGS=$(journalctl -u ${SERVICE_NAME} --since "${TIME_WINDOW}" | grep "ERROR" | grep -v "retrying")

if [ -n "${ERROR_LOGS}" ]; then
  MESSAGE="ERROR: ${NODE_NAME} service (${SERVICE_NAME}) has reported errors in the last 5 minutes:\n\`\`\`${ERROR_LOGS}\`\`\`"
  send_slack_notification "${MESSAGE}"
  exit 1
fi

echo "${NODE_NAME} is running correctly."
exit 0
