#!/bin/sh
# whitelist-report.sh
# Simply outputs the names of everyone on the whitelist

TOTAL=$(jq length whitelist.json)
NAMES=$(jq -r '.[].name' whitelist.json)

echo "Total: $TOTAL"
echo -e "People:\n$NAMES"
