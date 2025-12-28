#!/bin/bash

# 1. Capture the input from the user
SOURCE_DIR=$1
TARGET_DIR="$HOME/programming/bash-labs/02-smart-backup/backups"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$HOME/programming/bash-labs/02-smart-backup/backup.log"

# 2. Requirement: Check if the user even provided an argument
if [ -z "$SOURCE_DIR" ]; then
    echo "[$TIMESTAMP] ERROR: No directory provided. Usage: ./backup.sh <directory_path>" | tee -a "$LOG_FILE"
    exit 1
fi

# 3. Requirement: Check if the directory actually exists
if [ -d "$SOURCE_DIR" ]; then
    mkdir -p "$TARGET_DIR"
    
    # Using tar is better than cp for backups (it compresses!)
    tar -czf "$TARGET_DIR/backup_$TIMESTAMP.tar.gz" "$SOURCE_DIR" 2>> "$LOG_FILE"

    # 4. Check if the tar command actually worked
    if [ $? -eq 0 ]; then
        echo "[$TIMESTAMP] SUCCESS: Backup of $SOURCE_DIR created." | tee -a "$LOG_FILE"
    else
        echo "[$TIMESTAMP] ERROR: Backup failed (is the disk full?)" | tee -a "$LOG_FILE"
        exit 1
    fi
else
    echo "[$TIMESTAMP] ERROR: Directory $SOURCE_DIR does not exist." | tee -a "$LOG_FILE"
    exit 1
fi
