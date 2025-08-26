#!/bin/bash

LOGFILE="ips.log"

if [ ! -f "$LOGFILE" ]; then
    echo "Log file '$LOGFILE' not found!"
    exit 1
fi

TOP_RESULTS=20

if [ "$1" == "all" ]; then
    TOP_RESULTS="all"
elif [ -n "$1" ] && [[ "$1" =~ ^[0-9]+$ ]]; then
    TOP_RESULTS="$1"
fi

echo "===== IP Stats ====="

total=$(wc -l < "$LOGFILE")
echo "TOTAL ATTEMPTS: $total"

unique=$(sort "$LOGFILE" | uniq)
unique_count=$(echo "$unique" | wc -l)
echo "UNIQUE IPs: $unique_count"

echo "Top IPs by attempt count:"
echo "-------------------------"
if [ "$TOP_RESULTS" == "all" ]; then
    sort "$LOGFILE" | uniq -c | sort -nr
else
    sort "$LOGFILE" | uniq -c | sort -nr | head -n "$TOP_RESULTS"
fi
echo ""
