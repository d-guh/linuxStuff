#!/bin/bash
# start.sh
# Starts the tModLoader server in a tmux session.

SESSION_NAME="tmodloader"
SCRIPT_DIR=$(dirname "$(realpath "$0")")
START_SCRIPT="$SCRIPT_DIR/start-tModLoaderServer.sh"
START_ARGS="-nosteam"
DEFAULT_CONFIG="serverconfig.txt"
EDIT_CONFIG="serverconfig-edit.txt"

cd "$SCRIPT_DIR" || { echo "Failed to change directory to $SCRIPT_DIR"; exit 1; }

if [[ "$1" == "--edit" ]]; then
    CONFIG_FILE="$EDIT_CONFIG"
    echo "Launching tModLoader in edit mode using config: $CONFIG_FILE"
else
    CONFIG_FILE="$DEFAULT_CONFIG"
    echo "Launching tModLoader in server mode using config: $CONFIG_FILE"
fi

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    echo "tmux session '$SESSION_NAME' already exists. Aborting."
    exit 1
fi

# Start tModLoader in a new tmux session
tmux new-session -d -s "$SESSION_NAME" "$START_SCRIPT -config $CONFIG_FILE $START_ARGS"
tmux select-pane -t "$SESSION_NAME".0 -T "tModLoader Server"

echo "tModLoader server started in tmux session: $SESSION_NAME"
echo "Attach to session with 'tmux attach -t $SESSION_NAME'"
echo "Detach with 'Ctrl-b d'"