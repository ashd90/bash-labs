#!/bin/bash

# 1. Locate the directory where this script actually lives
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

usage() {
  echo "Usage: $0 [option] [argument]"
  echo "Options:"
  echo " --health    : Run the system health check"
  echo " --backup    : Run backup (requires path: --backup /source/dir)"
  echo " --user      : Setup Users from users.txt"
  echo " --analyze   : Analyze web logs (access.log)"
  echo " --service   : Run the service watchdog"
  echo " --apicheck  : Check if a website is up"
}

# Check if an argument was provided at all
if [ -z "$1" ]; then
    usage
    exit 1
fi

case "$1" in
  --health)
      echo "--- Starting Health Check ---"
      bash "$SCRIPT_DIR/01-system-health/health_check.sh"
      ;;
  --backup)
      echo "--- Starting Backup ---"
      # Pass $2 (the folder path) to the backup script
      bash "$SCRIPT_DIR/02-smart-backup/backup.sh" "$2"
      ;;
  --user)
      echo "--- Creating Users ---"
      # This usually needs sudo
      sudo bash "$SCRIPT_DIR/03-user-management/onboard.sh"
      ;;
  --analyze)
      echo "--- Analyzing Logs ---"
      bash "$SCRIPT_DIR/04-log-parser/analyze.sh"
      ;;
  --service)
      echo "--- Starting Service Watchdog ---"
      # Runs the monitor in this terminal
      sudo bash "$SCRIPT_DIR/05-service-watchdog/monitor.sh"
      ;;
  --apicheck)
      echo "--- API Check ---"
      bash "$SCRIPT_DIR/06-api-checker/api_test.sh"
      ;;
  *)
      echo "Error: Invalid option '$1'"
      usage
      exit 1
      ;;
esac
