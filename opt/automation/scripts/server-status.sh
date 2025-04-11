#!/bin/sh
# server-status.sh
# Sends out a status update to a discord webhook.
# crontab: */5 * * * * /opt/automation/scripts/server_status.sh

WEBHOOK_URL="" # ADD URL HERE

get_memory_usage() {
    MEM_USAGE=$(free | awk '/Mem/ {printf "%.0f", ($3/$2) * 100}') # Rounded
    TOTAL=$(free -m | awk '/Mem:/ {print $2}')
    USED=$(free -m | awk '/Mem:/ {print $3}')
    echo "${USED}MB / ${TOTAL}MB (${MEM_USAGE}%)"
}

# Collect Server Status
SERVER_TIME=$(date +"%Y-%m-%d %H:%M:%S")

CPU_USAGE=$(mpstat 1 1 | awk '/Average/ {print 100 - $NF}')

MEMORY_USAGE=$(get_memory_usage)

CPU_TEMP=$(sensors 2>/dev/null | awk '/Tctl|Package id 0/ {print $2}' | sed 's/+//;s/°C//;q')
CPU_TEMP=${CPU_TEMP:-0} # Default 0 if empty

DISK_USAGE=$(df -h / | awk 'NR==2{print $3 " / " $2 " (" $5 ")"}')

# Create Embed Message Payload
JSON_PAYLOAD=$(printf '{
    "embeds": [
        {
            "color": 3447003,
            "fields": [
                {
                    "name": "Server Time",
                    "value": "%s",
                    "inline": false
                },
                {
                    "name": "CPU",
                    "value": "**Usage**: %s%%\\n**Temp**: %s°C",
                    "inline": false
                },
                {
                    "name": "Memory",
                    "value": "**Usage**: %s",
                    "inline": false
                },
                {
                    "name": "Disk Space",
                    "value": "%s",
                    "inline": false
                }
            ]
        }
    ]
}' "$SERVER_TIME" "$CPU_USAGE" "$CPU_TEMP" "$MEMORY_USAGE" "$DISK_USAGE")

# Send Message
logger -t server-status "Status: CPU: $CPU_USAGE, $CPU_TEMP, RAM: $MEMORY_USAGE, DISK: $DISK_USAGE"
curl -H "Content-Type: application/json" -X POST -d "$JSON_PAYLOAD" "$WEBHOOK_URL"
