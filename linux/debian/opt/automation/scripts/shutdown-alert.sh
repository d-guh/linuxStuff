#!/bin/sh
# shutdown-alert.sh
# (Hopefully) sends an alert whenever the server is shutting down
# This one is likley best implemented as a service
#
# Dependencies:
# - curl
# - logger
# - date

# Config Vars
WEBHOOK_URL="" # ADD URL HERE
LOG_TAG_PREFIX="automation"
LOG_TAG="shutdown-alert"

SERVER_TIME=$(date +"%Y-%m-%d %H:%M:%S %Z")
MESSAGE="<@348121438169071618> :red_circle: :stop_sign:\\n**The server is shutting down**\\nServer Time: \`$SERVER_TIME\`"

logger -t "$LOG_TAG_PREFIX.$LOG_TAG" "Server is shutting down..."
curl -s -H "Content-Type: application/json" -X POST -d "{\"content\": \"$MESSAGE\"}" "$WEBHOOK_URL" >/dev/null 2>&1
