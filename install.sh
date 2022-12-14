#!/usr/bin/env bash

# Script to install and configure my personal Ubuntu Server with Pi-hole
#
# Author: Cristiano Fraga G. Nunes <cfgnunes@gmail.com>

set -eu

SCRIPT_NAME=$(basename "$0")

_main() {
    _run_as_sudo

    _log "Setting the time zone..."
    dpkg-reconfigure tzdata

    _log "Updating distro packages and removing some unnecessary packages..."
    apt-get -y purge snapd
    apt-get update
    apt-get -y full-upgrade
    apt-get -y install sqlite3

    _log "Installing Pi-hole..."
    local BACKUP_FLAGS=$-
    set +u
    wget -O basic-install.sh https://install.pi-hole.net
    PIHOLE_SKIP_OS_CHECK=true bash basic-install.sh
    set -"$BACKUP_FLAGS"

    _log "Setting the file 'dns-servers.conf'..."
    cp dns-servers.conf /etc/pihole/dns-servers.conf
    chown root:root /etc/pihole/dns-servers.conf
    chmod 644 /etc/pihole/dns-servers.conf

    _log "Setting the file 'adlists.list'..."
    while read -r LINE; do
        sqlite3 /etc/pihole/gravity.db "insert or ignore into adlist (address, enabled) values (\"$LINE\", 1);"
    done <"adlists.list"

    _log "Updating gravity list..."
    pihole -g

    _log "Installing the script ',pihole-distractions.sh'..."
    cp ,pihole-distractions.sh /usr/local/bin/,pihole-distractions.sh
    chown root:root /usr/local/bin/,pihole-distractions.sh
    chmod 755 /usr/local/bin/,pihole-distractions.sh

    _log "Installing the script ',update-system.sh'..."
    cp ,update-system.sh /usr/local/bin/,update-system.sh
    chown root:root /usr/local/bin/,update-system.sh
    chmod 755 /usr/local/bin/,update-system.sh

    _log "Setting the file 'crontab' (automatize the blacklist)..."
    cp crontab /etc/crontab
    chown root:root /etc/crontab
    chmod 644 /etc/crontab

    _log "Setting the file 'hosts'..."
    cp hosts /etc/hosts
    chown root:root /etc/hosts
    chmod 644 /etc/hosts

    # Set some URLs in whitelist
    while read -r LINE; do
        pihole -w "$LINE"
    done <"whitelist.list"

    apt-get autoremove --purge
    apt-get clean
}

_log() {
    local MESSAGE=$1

    logger -s "[$SCRIPT_NAME] $MESSAGE"
}

_get_command_path() {
    local COMMAND=$1
    local COMMAND_PATH

    COMMAND_PATH=$(command -v "$COMMAND") &>/dev/null || true
    echo "$COMMAND_PATH"
}

_run_as_sudo() {
    if ((EUID != 0)); then
        if [[ -n "$(_get_command_path 'sudo')" ]]; then
            sudo --preserve-env "$0"
        elif [[ -n "$(_get_command_path 'gksu')" ]]; then
            gksu --preserve-env "$0"
        else
            _log "You must run the script as root."
            exit 1
        fi
        exit 0
    fi
}

_main "$@"
