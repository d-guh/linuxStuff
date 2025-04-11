#!/bin/bash
# shutdown_alert.sh
# (Hopefully) sends an alert whenever the server is shutting down
# This one is likley best implemented as a service

WEBHOOK_URL="" # ADD URL HERE

SERVER_TIME=$(echo $(date +"%Y-%m-%d %H:%M:%S %Z"))
MESSAGE="<@348121438169071618> :red_circle: :stop_sign:\\n**The server is shutting down**\\nServer Time: \`$SERVER_TIME\`"

logger -t shutdown-alert "Server is shutting down..."
curl -H "Content-Type: application/json" -X POST -d "{\"content\": \"$MESSAGE\"}" "$WEBHOOK_URL"
