#!/bin/sh
# config.sh
# Shared configuration file for minecraft server scripts

SERVER_NAME="NAME" # In the form NAME-#-##-#
SERVER_DIR="/srv/minecraft/$SERVER_NAME"
MINECRAFT_JAR="$SERVER_DIR/server.jar"
LOG_FILE="$SERVER_DIR/logs/latest.log"
START_SCRIPT="$SERVER_DIR/start.sh"
MONIT_WEBHOOK_URL="" # Dont forget to set
ALERT_WEBHOOK_URL="" # Dont forget to set
MEMORY="8G" # Adjust as needed
