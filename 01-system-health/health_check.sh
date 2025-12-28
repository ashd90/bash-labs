#!/bin/bash

# Define the report file name
REPORT_FILE="server_report.txt"

echo "------------------------------------------" > $REPORT_FILE
echo "SYSTEM HEALTH REPORT - $(date)" >> $REPORT_FILE
echo "------------------------------------------" >> $REPORT_FILE

# Append Uptime (>> appends)
echo -e "\n1. UPTIME" >> $REPORT_FILE
uptime -p >> $REPORT_FILE

# Append Disk Usage
echo -e "\n2. DISK USAGE" >> $REPORT_FILE
df -h | grep '^/dev/' >> $REPORT_FILE

# Append Memory Usage
echo -e "\n3. MEMORY USAGE" >> $REPORT_FILE
free -m >> $REPORT_FILE

echo -e "\nReport generated successfully in $REPORT_FILE"
