#!/bin/bash

# Ensure the script is run with appropriate permissions
# Check if the script is executed as the root user, and if not, display a warning and exit.
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Total CPU Usage
# Use `top` in batch mode to get CPU stats, extract the line with CPU usage, and calculate idle percentage.
# Subtract the idle CPU percentage from 100% to get total CPU usage.
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8 "%"}')
echo "Total CPU Usage: $cpu_usage"

# Total Memory Usage
# Use `free` to get memory stats in MB. Extract total, used, and free memory.
# Calculate memory usage as a percentage of the total memory.
mem_info=$(free -m)
mem_total=$(echo "$mem_info" | awk '/^Mem:/ {print $2}')  # Total memory in MB
mem_used=$(echo "$mem_info" | awk '/^Mem:/ {print $3}')   # Used memory in MB
mem_free=$(echo "$mem_info" | awk '/^Mem:/ {print $4}')   # Free memory in MB
mem_percent=$(awk "BEGIN {printf \"%.2f\", ($mem_used/$mem_total)*100}")  # Calculate memory usage percentage
echo "Total Memory Usage: $mem_used MB used / $mem_total MB total ($mem_percent%)"

# Total Disk Usage
# Use `df` with the `--total` flag to get disk usage across all mounted filesystems.
# Extract total used, free, and percentage usage from the "total" line.
disk_info=$(df -h --total | grep "total")
disk_used=$(echo "$disk_info" | awk '{print $3}')    # Total used disk space
disk_free=$(echo "$disk_info" | awk '{print $4}')    # Total free disk space
disk_percent=$(echo "$disk_info" | awk '{print $5}') # Disk usage percentage
echo "Total Disk Usage: $disk_used used / $disk_free free ($disk_percent)"

# Top 5 Processes by CPU Usage
# Use `ps` to display running processes, sorted by CPU usage in descending order.
# Display only the PID, command name, and CPU percentage, and take the top 5.
echo "Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

# Top 5 Processes by Memory Usage
# Similar to the CPU usage command, but sort processes by memory usage instead.
echo "Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6

# Stretch Goals

# OS Version
# Use `lsb_release` to get the description of the OS (e.g., Ubuntu 20.04).
os_version=$(lsb_release -d | awk -F'\t' '{print $2}')
echo "Operating System: $os_version"

# Uptime
# Use `uptime` with the `-p` flag to display the system uptime in a human-readable format.
uptime_info=$(uptime -p)
echo "Uptime: $uptime_info"

# Load Average
# Extract the load average from the output of `uptime`.
# This shows the average system load over 1, 5, and 15 minutes.
load_average=$(uptime | awk -F'load average:' '{print $2}')
echo "Load Average (1, 5, 15 min): $load_average"

# Logged-in Users
# Use `who` to list logged-in users and count the lines to get the total number of users.
logged_in_users=$(who | wc -l)
echo "Logged-in Users: $logged_in_users"

# Failed Login Attempts
# Search for "Failed password" in the authentication logs (`/var/log/auth.log`), suppress errors, and count the lines.
# This gives the number of failed login attempts.
failed_logins=$(grep "Failed password" /var/log/auth.log 2>/dev/null | wc -l)
echo "Failed Login Attempts: $failed_logins"

# End of Script