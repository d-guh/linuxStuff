#!/bin/sh
# reboot.sh
# Reboots server with a 5m warning
# 
# Dependencies:
# - wall (from util-linux package)
# - curl
# - logger
# - sleep
# - reboot

# Config Vars
WEBHOOK_URL="" # ADD URL HERE
LOG_TAG_PREFIX="automation"
LOG_TAG="reboot"

# Helper Functions
send_discord_message() {
    message="$1"
    if [ -n "$WEBHOOK_URL" ]; then
        discord_message="**$message**"
        curl -s -H "Content-Type: application/json" -X POST -d "{\"content\": \"$message\"}" "$WEBHOOK_URL" >/dev/null 2>&1
    fi
}

log_and_notify() {
    message="$1"
    logger -t "$LOG_TAG_PREFIX.$LOG_TAG" "$message"
    wall "$message"
    send_discord_message "$message"
}

log_and_notify "Warning: The server will reboot in 5 minutes."

sleep 240

log_and_notify "WARNING: The server will reboot in 1 minute."

sleep 60

log_and_notify "The server is now rebooting."

sleep 1

# Stop critical systems here as needed

reboot
