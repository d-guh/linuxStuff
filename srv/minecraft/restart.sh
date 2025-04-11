#!/bin/bash
# restart.sh
# Gracefully stops and restarts the minecraft server
# crontab: 55 4 * * * /srv/minecraft/SERVER_NAME/restart.sh >> /srv/minecraft/SERVER_NAME/restart.log 2>&1

SCRIPT_DIR=$(dirname $(realpath $0))
source "$SCRIPT_DIR/config.sh"

KILL=false

echo "[$(date)] Initiating Minecraft server restart..."

if tmux has-session -t "$SERVER_NAME" 2>/dev/null; then
    echo "Sending restart warnings..."
    tmux send-keys -t "$SERVER_NAME".0 "say Server restarting in 5 minutes! Save your progress or get to a safe spot!" C-m
    sleep 240
    tmux send-keys -t "$SERVER_NAME".0 "say Server restarting in 1 minute!" C-m
    echo "1 minute warning sent."
    sleep 30
    tmux send-keys -t "$SERVER_NAME".0 "say Server restarting in 30 seconds!" C-m
    echo "30 second warning sent."
    sleep 20
    tmux send-keys -t "$SERVER_NAME".0 "say Server restarting in 10 seconds!" C-m
    echo "10 second warning sent."
    sleep 5
    for i in {5..1}; do
        tmux send-keys -t "$SERVER_NAME".0 "say Server restarting in $i..." C-m
        echo "$i"
        sleep 1
    done
else
    echo "No active tmux session found for '$SERVER_NAME'."
    exit 1
fi

echo "Stopping log monitoring scripts..."
if tmux list-panes -t "$SERVER_NAME" -F '#P' | grep -q '^2$'; then
    tmux send-keys -t "$SERVER_NAME".2 C-c
    echo "Stopped pane 2 (Log Alert)."
else
    echo "Pane 2 not found. Skipping."
fi

if tmux list-panes -t "$SERVER_NAME" -F '#P' | grep -q '^1$'; then
    tmux send-keys -t "$SERVER_NAME".1 C-c
    echo "Stopped pane 1 (Log Monitor)."
else
    echo "Pane 1 not found. Skipping."
fi

echo "Stopping Minecraft server..."
tmux send-keys -t "$SERVER_NAME".0 "stop" C-m

# Wait for shutdown
sleep 20

if tmux has-session -t "$SERVER_NAME" 2>/dev/null; then
    echo "Tmux session '$SERVER_NAME' still alive. Something probably went wrong."
    if KILL; then
        echo "KILL set to true, killing tmux session."
        tmux kill-session -t "$SERVER_NAME"
    else
        echo "KILL set to false, aborting."
        exit 1
    fi
fi

echo "Restarting Minecraft server..."
bash "$START_SCRIPT"
echo "[$(date)] Minecraft server restarted successfully."
