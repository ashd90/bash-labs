#!/bin/bash

# Define the URL to check
URL="https://www.google.com"

# 1. Fetch the status code
# -s: silent
# -o /dev/null: ignore body
# -w: write out only the code
STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$URL")

# 2. Check the result
if [ "$STATUS_CODE" -eq 200 ]; then
    echo "[$(date)] SUCCESS: $URL is reachable (Status: $STATUS_CODE)"
else
    echo "[$(date)] ALERT: $URL might be down! (Status: $STATUS_CODE)"
fi
