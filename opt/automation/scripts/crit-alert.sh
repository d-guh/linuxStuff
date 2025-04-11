#!/bin/sh
# crit-alert.sh
# Sends out an alert when system values are at critical levels
# crontab: */1 * * * * /opt/automation/scripts/crit-alert.sh

WEBHOOK_URL="" # ADD URL HERE

# Define thresholds
CPU_USAGE_THRESHOLD=89    # % CPU usage (89)
MEM_USAGE_THRESHOLD=89    # % memory usage (89)
TEMP_THRESHOLD=79         # °C CPU Temp (79)

# Fetch metrics
CPU_USAGE=$(mpstat 1 1 | awk '/Average/ {print 100 - $NF}')
MEM_USAGE=$(free | awk '/Mem/ {printf "%.2f", $3/$2 * 100}')
CPU_TEMP=$(sensors 2>/dev/null | awk '/Tctl|Package id 0/ {print $2}' | sed 's/+//;s/°C//;q')

CPU_TEMP=${CPU_TEMP:-0} # 0 if empty

ALERT_CONTENT=""

# Check conditions and send alert if any threshold is exceeded
if [ "$(echo "$CPU_USAGE > $CPU_USAGE_THRESHOLD" | bc)" -eq 1 ]; then
    ALERT_CONTENT="${ALERT_CONTENT}:warning: **High CPU Usage**\\nCPU Usage: \`$CPU_USAGE%\`\\n"
    logger -t crit-alert "High CPU usage detected: $CPU_USAGE%."
fi

if [ "$(echo "$MEM_USAGE > $MEM_USAGE_THRESHOLD" | bc)" -eq 1 ]; then
    ALERT_CONTENT="${ALERT_CONTENT}:warning: **High RAM Usage**\\nMemory Usage: \`$MEM_USAGE%\`\\n"
    logger -t crit-alert "High memory usage detected: $MEM_USAGE%."
fi

if [ "$(echo "$CPU_TEMP > $TEMP_THRESHOLD" | bc)" -eq 1 ]; then
    ALERT_CONTENT="${ALERT_CONTENT}:warning: **High CPU Temperature**\\nCPU Temperature: \`$CPU_TEMP°C\`\\n"
    logger -t crit-alert "High CPU Temperature detected: $CPU_TEMP°C."
fi

if [ -n "$ALERT_CONTENT" ]; then
    SERVER_TIME=$(date +"%Y-%m-%d %H:%M:%S %Z")

    MESSAGE="<@348121438169071618>\\n${ALERT_CONTENT}\\n:clock1: **Server Time:** \`$SERVER_TIME\`"

    curl -H "Content-Type: application/json" -X POST -d "{\"content\": \"$MESSAGE\"}" "$WEBHOOK_URL"
fi
