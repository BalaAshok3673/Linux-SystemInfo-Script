#!/bin/bash

# Function to display section headers
print_header() {
    echo "--------------------------------------------------"
    echo "$1"
    echo "--------------------------------------------------"
    echo
}

# Display system information
print_header "System Information"
echo "Hostname: $(hostname)"
echo "System Manufacturer: $(sudo dmidecode -s system-manufacturer)"
echo "System Product Name: $(sudo dmidecode -s system-product-name)"
echo "System Serial Number: $(sudo dmidecode -s system-serial-number)"
echo

# Display kernel information
print_header "Kernel Information"
echo "Kernel Version: $(uname -r)"
echo "Kernel Architecture: $(uname -m)"
echo "Kernel Build Date: $(uname -v)"
echo "Operating System: $(uname -o)"
echo

# Display distribution information
print_header "Distribution Information"
if command -v lsb_release > /dev/null; then
    lsb_release -a
else
    cat /etc/*release | head -n 1
fi
echo

# Detect desktop environment
print_header "Desktop Environment"
if [ -n "$XDG_CURRENT_DESKTOP" ]; then
    echo "Desktop Environment: $XDG_CURRENT_DESKTOP"
elif [ -f "$HOME/.Xresources" ]; then
    echo "Desktop Environment: $(tail -n 1 $HOME/.Xresources)"
else
    echo "Desktop Environment: Not found"
fi
echo

# Display installed applications (for Debian-based and Red Hat-based distributions)
print_header "Installed Applications"
if command -v dpkg-query > /dev/null; then
    echo "Installed Packages (Debian-based):"
    dpkg-query -l
    echo
elif command -v rpm > /dev/null; then
    echo "Installed Packages (Red Hat-based):"
    rpm -qa
    echo
else
    echo "Package manager not found."
fi

# Display uptime and load average
print_header "Uptime and Load"
uptime
echo

# Display CPU information
print_header "CPU Information"
lscpu
echo

# Display memory information
print_header "Memory Information"
free -h
echo

# Display disk usage
print_header "Disk Usage"
df -h /
echo

# Display filesystem information
print_header "Filesystem Information"
df -Th
echo

# Display mount points
print_header "Mount Points"
mount | column -t
echo

# Display network information
print_header "Network Information"
ip addr show
echo

# Display active connections
print_header "Active Connections"
netstat -tulpn
echo

# Display listening ports
print_header "Listening Ports"
ss -tulpn
echo

# Display logged-in users
print_header "Logged-In Users"
who
echo


