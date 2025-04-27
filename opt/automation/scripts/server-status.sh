#!/bin/sh
# server-status.sh
# Sends out a status update to a discord webhook.
# crontab: */5 * * * * /opt/automation/scripts/server_status.sh
#
# Dependencies:
# - curl
# - logger
# - free (from procps)
# - awk
# - mpstat (from sysstat)
# - sensors (from lm-sensors)
# - df
# - date

# Config Vars
WEBHOOK_URL="" # ADD URL HERE
LOG_TAG="server-status"

# Helper Functions
get_memory_usage() {
    mem_total=$(free -m | awk '/Mem:/ {print $2}')
    mem_used=$(free -m | awk '/Mem:/ {print $3}')
    mem_usage=$(free | awk '/Mem/ {printf "%.0f", ($3/$2) * 100}')

    mem_total=${mem_total:-"NA"}
    mem_used=${mem_used:-"NA"}
    mem_usage=${mem_usage:-"NA"}

    echo "${mem_used}MB / ${mem_total}MB (${mem_usage}%)"
}

# Collect Server Status
SERVER_TIME=$(date +"%Y-%m-%d %H:%M:%S %Z")

CPU_USAGE=$(mpstat 1 1 | awk '/Average/ {print 100 - $NF}')
CPU_USAGE=${CPU_USAGE:-"NA"}

MEMORY_USAGE=$(get_memory_usage)

CPU_TEMP=$(sensors 2>/dev/null | awk '/Tctl|Package id 0/ {print $2}' | sed 's/+//;s/°C//;q')
CPU_TEMP=${CPU_TEMP:-"NA"}

DISK_USAGE=$(df -h / | awk 'NR==2{print $3 " / " $2 " (" $5 ")"}')
DISK_USAGE=${DISK_USAGE:-"NA"}

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
logger -t "$LOG_TAG" "Status: CPU: ${CPU_USAGE}%, Temp: ${CPU_TEMP}°C, Memory: ${MEMORY_USAGE}, Disk: ${DISK_USAGE}"
curl -s -H "Content-Type: application/json" -X POST -d "$JSON_PAYLOAD" "$WEBHOOK_URL" >/dev/null 2>&1
