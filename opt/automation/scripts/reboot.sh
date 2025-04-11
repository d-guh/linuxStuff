#!/bin/bash
# reboot.sh
# I don't really use this one tbh

WEBHOOK_URL="" # ADD URL HERE

send_discord_message() {
    local message="$1"
    curl -H "Content-Type: application/json" -X POST -d "{\"content\": \"$message\"}" "$WEBHOOK_URL"
}

wall "Warning: The server will reboot in 5 minutes."
send_discord_message "**Warning: The server will reboot in 5 minutes.**"

sleep 240

wall "WARNING: The server will reboot in 1 minute."
send_discord_message "**WARNING: The server will reboot in 1 minute.**"

sleep 60

wall "The server is now rebooting."
send_discord_message "**<@348121438169071618> :red_square:\\nThe server is now rebooting.**"

sleep 1

# Stop critical systems here


/sbin/shutdown -r now
