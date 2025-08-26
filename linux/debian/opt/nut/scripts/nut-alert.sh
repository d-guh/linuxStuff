#!/bin/sh
# nut-alert.sh
# Sends out alerts/logs when a NUT event occurs.
# /etc/nut/upsmon.conf for config
#
# Dependencies:
# - nut (assumedly)
# - curl
# - logger

WEBHOOK_URL="https://discord.com/api/webhooks/1335325610561765476/oX41jKbvLjEBRUde-G6iM2Au_i9hfWaKD5HtQacAn3QaqN2Nq2uQEOjcElSWBqoUCUq_"
LOG_TAG="nut-alert"

EVENT="$1"
MESSAGE="<@348121438169071618> :zap: :information_source:\\n**NUT Event:** \`$EVENT\` detected on UPS 'ABST800'"

logger -t "$LOG_TAG" "NUT Event: $EVENT detected on UPS 'ABST800'"
curl -s -H "Content-Type: application/json" -X POST -d "{\"content\": \"$MESSAGE\"}" "$WEBHOOK_URL" >/dev/null 2>&1
