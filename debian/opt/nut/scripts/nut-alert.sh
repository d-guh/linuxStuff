#!/bin/sh
# nut-alert.sh
# Sends out alerts/logs when a NUT event occurs.
# /etc/nut/upsmon.conf for config
#
# Dependencies:
# - nut (assumedly)
# - curl
# - logger

WEBHOOK_URL="" # ADD URL HERE
LOG_TAG_PREFIX="automation"
LOG_TAG="nut-alert"

EVENT="$1"
MESSAGE="<@348121438169071618> :zap: :information_source:\\n**NUT Event:** \`$EVENT\` detected on UPS 'ABST800'"
LOG_MESSAGE="$LOG_TAG_PREFIX.$LOG_TAG" "NUT Event: $EVENT detected on UPS 'ABST800'"

logger -t "$LOG_TAG_PREFIX.$LOG_TAG" "$LOG_MESSAGE"
curl -s -H "Content-Type: application/json" -X POST -d "{\"content\": \"$MESSAGE\"}" "$WEBHOOK_URL" >/dev/null 2>&1
