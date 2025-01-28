# server-stats

https://roadmap.sh/projects/server-stats

Goal of this project is to write a script to analyse server performance stats.

Requirements:

You are required to write a script server-stats.sh that can analyse basic server performance stats. You should be able to run the script on any Linux server and it should give you the following stats:

- Total CPU usage
- Total memory usage (Free vs Used including percentage)
- Total disk usage (Free vs Used including percentage)
- Top 5 processes by CPU usage
- Top 5 processes by memory usage

Stretch goal: Feel free to optionally add more stats such as os version, uptime, load average, logged in users, failed login attempts etc.

```
dtrac$ vagrant ssh -c "sudo bash -s" < ../../Documents/server-stats.sh 
Total CPU Usage: 11.4%
Total Memory Usage: 192 MB used / 1766 MB total (10.87%)
Total Disk Usage: 2.8G used / 72G free (4%)
Top 5 Processes by CPU Usage:
    PID COMMAND         %CPU
   3283 sshd             2.0
   3287 sudo             2.0
    822 tuned            1.8
      1 systemd          1.5
    758 firewalld        1.0
Top 5 Processes by Memory Usage:
    PID COMMAND         %MEM
    758 firewalld        2.9
    822 tuned            1.7
    858 polkitd          1.4
    804 NetworkManager   1.0
      1 systemd          0.7
Operating System: Red Hat Enterprise Linux 8.9 (Ootpa)
Uptime: up 1 minute
Load Average (1, 5, 15 min):  0.30, 0.14, 0.05
Logged-in Users: 0
Failed Login Attempts: 0

