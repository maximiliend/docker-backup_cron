#!/bin/bash

# Variables

webcontainer=$WEB_CONTAINER
webvolume=$WEB_VOLUME

sqlcontainer=$SQL_CONTAINER
sqluser=$SQL_USER
sqlpassword=$SQL_PASSWORD
sqldatabase=$SQL_DATABASE

# Functions

function log {
    echo "[$(date '+%d-%m-%Y %H:%M:%S')] - $@"
}

function backup_web {
    log "Start Web backup"
}

function backup_sql {
    log "Start SQL backup"
}

# Main

backup_web
backup_sql

exit 0
