#!/bin/bash

# Variables

source /variables

date=$(date +"%d-%m-%y")

# Functions

function log {
    echo "[$(date '+%d-%m-%Y %H:%M:%S')] - $@"
}

function backup_web {
    log "Web backup - Start"
}

function backup_sql {
    log "SQL backup - Start"

    mysqldump --all-databases --routines --complete-insert --add-drop-database --add-drop-table --add-locks -h $sqlcontainer -P $sqlport -u root -p$sqlpassword | gzip > /tmp/${date}_dump.sql.gz

    log "SQL backup - Done with a file size of $(stat -c '%s' /tmp/${date}_dump.sql.gz)"
}

# Main

#backup_web
backup_sql

exit 0
