#!/bin/bash
# log-monitor-batching.sh
# Author: Dylan Harvey
# Monitors a minecraft logfile for relevant updates and posts to a discord webhook.
# NOT CURRENTLY WORKING RIGHT - FIX THIS

LOG_FILE="./logs/latest.log"
WEBHOOK_URL=""
BATCH_INTERVAL=10
MESSAGE_QUEUE=()
LAST_FLUSH=$(date +%s)

if [ ! -f "$LOG_FILE" ]; then
    echo "Logfile $LOG_FILE does not exist!"
    exit 1
fi

if [ -z "$WEBHOOK_URL" ]; then
    echo "Webhook URL not set!"
    exit 1
fi

send_discord_message() {
    local message="$1"
    echo "Sending: $message"
    curl -H "Content-Type: application/json" -X POST -d "{\"content\": \"$message\"}" "$WEBHOOK_URL"
}

flush_queue() {
    if [ ${#MESSAGE_QUEUE[@]} -eq 0 ]; then
        return
    fi

    local combined_message
    combined_message=$(printf "\`%s\`\n" "${MESSAGE_QUEUE[@]}" | sed ':a;N;$!ba;s/\n/\\n/g') # Discord friendly json

    send_discord_message "$combined_message"

    MESSAGE_QUEUE=()
    LAST_FLUSH=$(date +%s)
}

cleanup() {
    echo "Stopping Monitoring $LOG_FILE"
    flush_queue
    send_discord_message ":octagonal_sign: **Stopped Monitoring** \`$LOG_FILE\`"
    exit 0
}

trap cleanup SIGINT SIGTERM

echo "Started Monitoring $LOG_FILE"
send_discord_message ":information_source: **Started Monitoring** \`$LOG_FILE\`"

FLUSH_PID=$!

# Main Loop
# This sucks, unfortunatley blocking from read, but works
tail -Fn0 "$LOG_FILE" | while read -r LINE; do
    LINE=$(echo "$LINE" | sed 's/"/\\"/g')  # Escape double quotes
    MESSAGE_QUEUE+=("$LINE")

    # Check if it's time to flush the queue
    if (( $(date +%s) % BATCH_INTERVAL == 0 )); then
        flush_queue
    fi
done