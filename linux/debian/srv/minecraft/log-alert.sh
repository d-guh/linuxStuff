#!/bin/bash
# log-alert.sh
# Monitors a Minecraft Server's latest.log for updates and posts embed alerst to a webhook.

SCRIPT_DIR=$(dirname $(realpath $0))
source "$SCRIPT_DIR/config.sh"

CACHE=$(date +'%Y%m%d')

if [ ! -f "$LOG_FILE" ]; then
    echo "Logfile $LOG_FILE does not exist!"
    exit 1
fi

if [ -z "$ALERT_WEBHOOK_URL" ]; then
    echo "Webhook URL not set!"
    exit 1
fi

send_discord_embed() {
    curl -H "Content-Type: application/json" \
        -X POST \
        -d '{
                "embeds": [{
                    "color": '"$2"',
                    "author": {
                        "name": "'"$1"'",
                        "icon_url": "'"$3"'"
                    }
                }]
            }' "$ALERT_WEBHOOK_URL"
}

cleanup () {
    echo "Stopping Monitoring $LOG_FILE"
    send_discord_message ":octagonal_sign: **Stopped Monitoring** \`$LOG_FILE\`"
    exit 0
}

trap cleanup SIGINT SIGTERM

echo "Started Watching $LOG_FILE"

tail -n 0 -F $LOG_FILE | while read -r LINE; do
    case $LINE in

    *\<*\>*)
        CHAT=$(echo "$LINE" | sed -E 's/^.*INFO\]: (<[^>]+> .*)/\1/')
        echo "Chat: $CHAT"
        ;;

    # joins and leaves
    *joined\ the\ game)
        PLAYER=$(echo "$LINE" | grep -o ": .*" | awk '{print $2}')
        echo "$PLAYER joined. Sending webhook..."
        send_discord_embed "$PLAYER joined the game." 6473516 "https://minotar.net/helm/$PLAYER?v=$CACHE"
        ;;

    *left\ the\ game)
        PLAYER=$(echo "$LINE" | grep -o ": .*" | awk '{print $2}')
        echo "$PLAYER left. Sending webhook..."
        send_discord_embed "$PLAYER left the game." 9737364 "https://minotar.net/helm/$PLAYER?v=$CACHE"
        ;;

    # death messages
    # Really gotta get a better way to match these
    *was\ slain\ by*|*was\ shot\ by*|*was\ blown\ up\ by*|*was\ fireballed\ by*|*was\ burnt\ to\ a\ crisp*|\
    *was\ pummeled\ by*|*was\ killed\ by\ magic*|*was\ killed\ trying\ to\ hurt*|*was\ doomed\ to\ fall*|\
    *was\ squashed\ by*|*was\ obliterated\ by*|*was\ fireballed\ by*|*was\ killed\ by*|*was\ stung\ to\ death*|\
    *was\ impaled\ on\ a\ stalagmite*|*was\ pricked\ to\ death*|*was\ roasted\ in\ lava*|*was\ drowned*|\
    *was\ crushed\ by*|*was\ slain\ by\ a\ vex*|*was\ slain\ by\ an\ enderman*|*died\ from\ dehydration*|\
    *drowned*|*fell\ from\ a\ high\ place*|*fell\ off\ a\ ladder*|*fell\ off\ some\ vines*|*fell\ off\ scaffolding*|\
    *hit\ the\ ground\ too\ hard*|*fell\ into\ a\ patch\ of\ sweet\ berries*|*was\ doomed\ to\ fall\ by*|\
    *was\ squashed\ by\ a\ falling\ anvil*|*was\ squashed\ by\ a\ falling\ block*|*was\ killed\ by\ contact*|\
    *discovered\ the\ floor\ was\ lava*|*walked\ into\ danger\ zone\ due\ to*|*was\ roasted\ in\ dragon\'s\ breath*|\
    *suffocated\ in\ a\ wall*|*experienced\ kinetic\ energy*|*went\ off\ with\ a\ bang*|*blew\ up*|\
    *was\ blown\ up*|*was\ struck\ by\ lightning*|*froze\ to\ death*|*died\ from\ dehydration*|*withered\ away*)
        PLAYER=$(echo "$LINE" | grep -o ": .*" | awk '{print $2}')
        MESSAGE=$(echo "$LINE" | grep -o ": .*" | cut -c 3-)
        echo "$PLAYER died. Sending webhook..."
        send_discord_embed "$MESSAGE" 10366780 "https://minotar.net/helm/$PLAYER?v=$CACHE"
        ;;

    # advancements
    *has\ made\ the\ advancement* | *completed\ the\ challenge* | *reached\ the\ goal*)
        PLAYER=$(echo "$LINE" | grep -o ": .*" | awk '{print $2}')
        MESSAGE=$(echo "$LINE" | grep -o ": .*" | cut -c 3-)
        echo "$PLAYER made an advancement! Sending webhook..."
        send_discord_embed "$MESSAGE" 2842864 "https://minotar.net/helm/$PLAYER?v=$CACHE"
        ;;

    esac
done
