#!/bin/sh
# crit-alert.sh
# Sends out an alert when system values are at critical levels
# crontab: */1 * * * * /opt/automation/scripts/crit-alert.sh
# 
# Dependencies:
# - mpstat (from sysstat package)
# - awk
# - free (from procps package)
# - sensors (from lm-sensors package)
# - curl
# - logger
# - date

# Config Vars
WEBHOOK_URL="" # ADD URL HERE
LOG_TAG_PREFIX="automation"
LOG_TAG="crit-alert"

# Define Thresholds
CPU_USAGE_THRESHOLD=89    # % CPU usage (89)
MEM_USAGE_THRESHOLD=89    # % memory usage (89)
TEMP_THRESHOLD=79         # °C CPU Temp (79)

# Helper Functions
send_discord_message() {
    message="$1"
    if [ -n "$WEBHOOK_URL" ]; then
        discord_message="**$message**"
        curl -s -H "Content-Type: application/json" -X POST -d "{\"content\": \"$message\"}" "$WEBHOOK_URL" >/dev/null 2>&1
    fi
}

# Fetch Metrics
CPU_USAGE=$(mpstat 1 1 | awk '/Average/ {print 100 - $NF}')
MEM_USAGE=$(free | awk '/Mem/ {printf "%.2f", $3/$2 * 100}')
CPU_TEMP=$(sensors 2>/dev/null | awk '/Tctl|Package id 0/ {print $2}' | sed 's/+//;s/°C//;q')

CPU_USAGE=${CPU_USAGE:-"NA"}
MEM_USAGE=${MEM_USAGE:-"NA"}
CPU_TEMP=${CPU_TEMP:-"NA"}

ALERT_CONTENT=""

# Check conditions and send alert if any threshold is exceeded
if awk "BEGIN {exit !($CPU_USAGE > $CPU_USAGE_THRESHOLD)}"; then
    ALERT_CONTENT="${ALERT_CONTENT}:warning: **High CPU Usage**\\nCPU Usage: \`$CPU_USAGE%\`\\n"
    logger -t "$LOG_TAG_PREFIX.$LOG_TAG" "High CPU usage detected: $CPU_USAGE%."
fi

if awk "BEGIN {exit !($MEM_USAGE > $MEM_USAGE_THRESHOLD)}"; then
    ALERT_CONTENT="${ALERT_CONTENT}:warning: **High RAM Usage**\\nMemory Usage: \`$MEM_USAGE%\`\\n"
    logger -t "$LOG_TAG_PREFIX.$LOG_TAG" "High memory usage detected: $MEM_USAGE%."
fi

if awk "BEGIN {exit !($CPU_TEMP > $TEMP_THRESHOLD)}"; then
    ALERT_CONTENT="${ALERT_CONTENT}:warning: **High CPU Temperature**\\nCPU Temperature: \`$CPU_TEMP°C\`\\n"
    logger -t "$LOG_TAG_PREFIX.$LOG_TAG" "High CPU Temperature detected: $CPU_TEMP°C."
fi

if [ -n "$ALERT_CONTENT" ]; then
    SERVER_TIME=$(date +"%Y-%m-%d %H:%M:%S %Z")
    MESSAGE="<@348121438169071618>\\n${ALERT_CONTENT}\\n:clock1: **Server Time:** \`$SERVER_TIME\`"
    send_discord_message "$MESSAGE"
fi
