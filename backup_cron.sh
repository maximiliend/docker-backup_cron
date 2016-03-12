#!/bin/bash

# Variables

source /variables

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
