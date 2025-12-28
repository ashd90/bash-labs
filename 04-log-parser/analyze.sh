#!/bin/bash

LOG_FILE="access.log"

# Check if log file exists (Good DevOps habit!)
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: $LOG_FILE not found."
    exit 1
fi

echo "--- Log Analysis Report ---"

# 1. Total Requests
TOTAL_LINES=$(wc -l < "$LOG_FILE")
echo "Total Requests:  $TOTAL_LINES"

# 2. Unique IPs
UNIQUE_IPS=$(awk '{print $1}' "$LOG_FILE" | sort | uniq | wc -l)
echo "Unique Visitors: $UNIQUE_IPS"

# 3. 404 Errors
ERRORS_404=$(grep -c '404' "$LOG_FILE") # grep -c is shorthand for 'grep | wc -l'
echo "404 Errors:      $ERRORS_404"

# 4. Top IP
echo -n "Top IP Address:  "
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 1

echo "---------------------------"
