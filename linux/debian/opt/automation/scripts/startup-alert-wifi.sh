#!/bin/sh
# startup-alert.sh
# Performs some actions and sends a message when the server starts and connects
# crontab: @reboot /opt/automation/scripts/startup-alert.sh
#
# Dependencies:
# - curl
# - logger
# - date
# - sudo
# - iwconfig (from wireless-tools)

# Config Vars
WEBHOOK_URL="" # ADD URL HERE
LOG_TAG_PREFIX="automation"
LOG_TAG="startup-alert"

sleep 1
# Disable power saving mode for the wifi card
sudo iwconfig wlp12s0 power off
logger -t startup-alert "Server started, power saving disabled."

# Allow time for WiFi to connect
sleep 10

SERVER_TIME=$(date +"%Y-%m-%d %H:%M:%S %Z")
MESSAGE="<@348121438169071618> :green_circle: :white_check_mark:\\n**Server has started successfully**\\nServer Time: \`$SERVER_TIME\`"

logger -t "$LOG_TAG_PREFIX.$LOG_TAG" "Server startup completed."
curl -s -H "Content-Type: application/json" -X POST -d "{\"content\": \"$MESSAGE\"}" "$WEBHOOK_URL" >/dev/null 2>&1
