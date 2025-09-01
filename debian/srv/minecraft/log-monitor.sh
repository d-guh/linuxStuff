#!/bin/bash
# log-monitor.sh
# Monitors a minecraft logfile for relevant updates and posts to a discord webhook.

SCRIPT_DIR=$(dirname $(realpath $0))
source "$SCRIPT_DIR/config.sh"

if [ ! -f "$LOG_FILE" ]; then
    echo "Logfile $LOG_FILE does not exist!"
    exit 1
fi

if [ -z "$MONIT_WEBHOOK_URL" ]; then
    echo "Webhook URL not set!"
    exit 1
fi

send_discord_message() {
    local message="$1"
    echo "Sending: $message"
    curl -H "Content-Type: application/json" -X POST -d "{\"content\": \"$message\"}" "$MONIT_WEBHOOK_URL"
}

cleanup() {
    echo "Stopping Monitoring $LOG_FILE"
    send_discord_message ":octagonal_sign: **Stopped Monitoring** \`$LOG_FILE\`"
    exit 0
}

trap cleanup SIGINT SIGTERM

echo "Started Monitoring $LOG_FILE"
send_discord_message ":information_source: **Started Monitoring** \`$LOG_FILE\`"

tail -Fn0 "$LOG_FILE" | while read -r LINE; do
    LINE=$(echo "$LINE" | sed 's/"/\\"/g')  # Escape double quotes
    send_discord_message "\`$LINE\`"
    sleep 0.3
done
