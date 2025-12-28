#!/bin/bash

SERVICE="docker"
LOG_FILE="service_monitor.log"

# Ensure script is run with sudo
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (sudo)"
   exit 1
fi

echo "Starting monitor for $SERVICE... (Press Ctrl+C to stop)"

while true
do
    if systemctl is-active --quiet $SERVICE; then
        # Optional: Comment this out if you only want to log failures
        echo "$(date): $SERVICE is running." 
    else
        echo "$(date): ALERT! $SERVICE is down. Attempting restart..." | tee -a "$LOG_FILE"
        
        systemctl start $SERVICE
        
        # Give it a second to initialize before checking again
        sleep 2 

        if systemctl is-active --quiet $SERVICE; then
            echo "$(date): SUCCESS: $SERVICE recovered." | tee -a "$LOG_FILE"
        else
            echo "$(date): CRITICAL: $SERVICE failed to restart!" | tee -a "$LOG_FILE"
        fi
    fi

    sleep 5
done
