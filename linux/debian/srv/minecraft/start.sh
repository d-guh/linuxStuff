#!/bin/bash
# start.sh
# Starts the specified minecraft server in a tmux session.

SCRIPT_DIR=$(dirname $(realpath $0))
source "$SCRIPT_DIR/config.sh"

cd "$SERVER_DIR" || { echo "Failed to change directory to $SERVER_DIR"; exit 1; }

echo "Running server in: '$SERVER_DIR' as user '$USER'"

if tmux has-session -t "$SERVER_NAME" 2>/dev/null; then
    echo "tmux session '$SERVER_NAME' already exists. Aborting."
    exit 1
fi

# Create a new detached tmux session to run the server
tmux new-session -d -s "$SERVER_NAME" "java -Xmx$MEMORY -Xms$MEMORY -jar $MINECRAFT_JAR nogui"
tmux select-pane -t "$SERVER_NAME".0 -T "Minecraft Server"


# Start log monitoring
tmux split-window -h -t "$SERVER_NAME" "$SCRIPT_DIR/log-monitor.sh"
tmux select-pane -t "$SERVER_NAME".1 -T "Log Monitor"

tmux split-window -v -t "$SERVER_NAME".1 "$SCRIPT_DIR/log-alert.sh"
tmux select-pane -t "$SERVER_NAME".2 -T "Log Alert"

echo "Minecraft server started in tmux session: $SERVER_NAME"
echo "Attach to session with 'tmux attach -t $SERVER_NAME'"
echo "Detach session with 'Ctrl-b d'"
