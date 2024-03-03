#!/bin/bash

# Defining variables
BACKUP_DST="/backups"
BACKUP_DATE=$(date +"%Y%m%d%H%M%S")
BACKUP_FILENAME="backup_$BACKUP_DATE.tar.gz"

# Function to display usage information
display_usage() {
    echo "Usage: $0 source_directory"
    exit 1
}

# Check if a source directory is provided
if [ "$#" -ne 1 ]; then
    echo "Error: Please provide a source directory to backup."
    display_usage
fi

BACKUP_SRC="$1"

# Create the backup directory
mkdir -p "$BACKUP_DST/$BACKUP_DATE"

# Log function
log_message() {
    message="$1"
    echo "$(date +"%Y-%m-%d %H:%M:%S"): $message" >> "$BACKUP_DST/$BACKUP_DATE/backup.log"
}

# Archive the source directory
tar -czf "$BACKUP_DST/$BACKUP_DATE/$BACKUP_FILENAME" "$BACKUP_SRC" 2>> "$BACKUP_DST/$BACKUP_DATE/backup.log"

# Verify the backup was created successfully
if [ $? -eq 0 ]; then
    log_message "Backup successful: $BACKUP_FILENAME"
    echo "Backup successful. Size of backup file: $(du -h "$BACKUP_DST/$BACKUP_DATE/$BACKUP_FILENAME" | cut -f1)"
else
    log_message "Backup failed"
    echo "Backup failed. Check the log file for details: $BACKUP_DST/$BACKUP_DATE/backup.log"
fi
