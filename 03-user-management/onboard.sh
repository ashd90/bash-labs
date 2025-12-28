#!/bin/bash

USER_FILE="users.txt"
LOG_FILE="setup.log"

# Check if the script is being run as root (Required to add users)
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (use sudo)"
  exit 1
fi

# Check if the input file exists
if [ ! -f "$USER_FILE" ]; then
    echo "Error: $USER_FILE not found!" | tee -a "$LOG_FILE"
    exit 1
fi

# The Loop
for USERNAME in $(cat $USER_FILE); do
    # Check if user already exists
    if id "$USERNAME" &>/dev/null; then
        echo "[$(date)] SKIP: User $USERNAME already exists." | tee -a "$LOG_FILE"
    else
        # 1. Create the user
        # -m creates the home directory /home/USERNAME
        useradd -m "$USERNAME"
        
        if [ $? -eq 0 ]; then
            echo "[$(date)] SUCCESS: User $USERNAME created." | tee -a "$LOG_FILE"
            
            # 2. Create a welcome file in their new home
            WELCOME_MESSAGE="Welcome to the server, $USERNAME! Your account was created on $(date)."
            echo "$WELCOME_MESSAGE" > "/home/$USERNAME/welcome.txt"
            
            # 3. Set proper ownership for the welcome file
            chown "$USERNAME":"$USERNAME" "/home/$USERNAME/welcome.txt"
        else
            echo "[$(date)] ERROR: Failed to add $USERNAME." | tee -a "$LOG_FILE"
        fi
    fi
done
