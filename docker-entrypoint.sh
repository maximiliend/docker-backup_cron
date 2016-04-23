#!/bin/bash
set -e

# Variables

if [ -z "$BACKUP_WEB_CONTAINER" ]; then
    echo >&2 'error: missing required WEB_CONTAINER environment variable'
    echo >&2 '  Did you forget to -e WEB_CONTAINER=... ?'
    exit 1
fi

if [ -z "$BACKUP_WEB_VOLUME" ]; then
    echo >&2 'error: missing required WEB_VOLUME environment variable'
    echo >&2 '  Did you forget to -e WEB_VOLUME=... ?'
    exit 1
fi

if [ -z "$BACKUP_SQL_CONTAINER" ]; then
    echo >&2 'error: missing required SQL_CONTAINER environment variable'
    echo >&2 '  Did you forget to -e SQL_CONTAINER=... ?'
    exit 1
fi

if [ -z "$BACKUP_SQL_USER" ]; then
    echo >&2 'error: missing required SQL_USER environment variable'
    echo >&2 '  Did you forget to -e SQL_USER=... ?'
    exit 1
fi

if [ -z "$BACKUP_SQL_PASSWORD" ]; then
    echo >&2 'error: missing required SQL_PASSWORD environment variable'
    echo >&2 '  Did you forget to -e SQL_PASSWORD=... ?'
    exit 1
fi

if [ -z "$BACKUP_SQL_DATABASE" ]; then
    echo >&2 'error: missing required SQL_DATABASE environment variable'
    echo >&2 '  Did you forget to -e SQL_DATABASE=... ?'
    exit 1
fi

if [ -z "$BACKUP_SQL_PORT" ]; then
    export BACKUP_SQL_PORT='3306'
fi

if [ -z "$BACKUP_CRON_HOUR" ]; then
    export BACKUP_CRON_HOUR='4'
fi

if [ -z "$BACKUP_CRON_MIN" ]; then
    export BACKUP_CRON_MIN='42'
fi

# Functions

set_variable () {
    if grep -q "^$1=" /variables
    then
        sed -i "/$1=/c\\$1=$2" /variables
    else
        echo "$1=$2" >> /variables
    fi
}

set_backup_cron () {
    # m h dom mon dow user  command
    echo "${BACKUP_CRON_MIN} ${BACKUP_CRON_HOUR} * * * root /backup_cron.sh >> /var/log/cron.log 2>&1" > /etc/cron.d/backup_cron
}

# Main

set_variable 'webcontainer' "$BACKUP_WEB_CONTAINER"
set_variable 'webvolume' "$BACKUP_WEB_VOLUME"
set_variable 'sqlcontainer' "$BACKUP_SQL_CONTAINER"
set_variable 'sqluser' "$BACKUP_SQL_USER"
set_variable 'sqlpassword' "$BACKUP_SQL_PASSWORD"
set_variable 'sqldatabase' "$BACKUP_SQL_DATABASE"
set_variable 'sqlport' "$BACKUP_SQL_PORT"

set_backup_cron

exec "$@"
