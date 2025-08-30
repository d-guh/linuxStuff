#!/bin/sh
# startup-alert.sh
# Sends a message when the server starts and connects
# crontab: @reboot /opt/automation/scripts/startup-alert.sh
#
# Dependencies:
# - curl
# - logger
# - date

# Config Vars
WEBHOOK_URL="" # ADD URL HERE
LOG_TAG_PREFIX="automation"
LOG_TAG="startup-alert"

SERVER_TIME=$(date +"%Y-%m-%d %H:%M:%S %Z")
MESSAGE="<@348121438169071618> :green_circle: :white_check_mark:\\n**Server has started successfully**\\nServer Time: \`$SERVER_TIME\`"
LOG_MESSAGE="Server startup completed"

logger -t "$LOG_TAG_PREFIX.$LOG_TAG" "$LOG_MESSAGE"
curl -s -H "Content-Type: application/json" -X POST -d "{\"content\": \"$MESSAGE\"}" "$WEBHOOK_URL" >/dev/null 2>&1
