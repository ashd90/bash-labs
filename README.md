# Bash Automation Labs: DevOps Foundations

A collection of 6 Bash-based automation projects designed to master system administration, data processing, and self-healing infrastructure. Developed on **Arch Linux**.

## 🚀 The Projects

1.  **System Health Reporter:** Gathers real-time stats on CPU, Memory, and Disk usage.
2.  **Smart Backup Tool:** Creates compressed backups with timestamps and error logging.
3.  **User Onboarding:** Automates user creation and home directory setup from a file list.
4.  **Web Log Analyzer:** Uses `grep`, `awk`, and `sed` to parse traffic patterns and identify top IPs.
5.  **Service Watchdog:** A "self-healing" monitor that automatically restarts services (Docker) if they crash.
6.  **API Checker:** Uses `curl` to monitor web application health via HTTP status codes.

## 🛠️ The Master Dashboard
The project includes a centralized CLI tool to manage all scripts from a single entry point.

### Usage
```bash
# Run the dashboard
./dashboard.sh [option]

# Options
--health    : View system stats
--backup    : Backup a specific directory
--user      : Run onboarding script
--analyze   : Parse access.log
--service   : Start the service watchdog
--apicheck  : Check website connectivity
