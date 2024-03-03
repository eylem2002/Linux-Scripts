#!/bin/bash

# disk space information
check_disk_space() {
    echo "Disk Space:"
    df -h
    echo "----------------------"
}

#memory usage information
check_memory_usage() {
    echo "Memory Usage:"
    free -h
    echo "----------------------"
}

# run services
check_running_services() {
    echo "Running Services:"
    systemctl list-units --type=service --state=running
    echo "----------------------"
}

# check system updates
check_system_updates() {
    echo "Recent System Updates:"
    if sudo apt update > /dev/null 2>&1; then
        sudo apt list --upgradable
    else
        echo "Unable to check for updates. Please ensure you have the necessary permissions."
    fi
    echo "----------------------"
}

# display overall system health
display_system_health() {
    echo "System Health Report:"
    check_disk_space
    check_memory_usage
    check_running_services
    check_system_updates
}

# Run the sustem
display_system_health
