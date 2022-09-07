#!/usr/bin/env bash

# Update all system packages
#
# Author: Cristiano Fraga G. Nunes <cfgnunes@gmail.com>

set -eu

SCRIPT_NAME=$(basename "$0")

_main() {
    sudo echo >/dev/null

    #_log "Updating and installing snap packages..."
    #sudo snap refresh

    _log "Updating apt list..."
    sudo apt-get update

    _log "Upgrading apt packages..."
    sudo apt-get -y full-upgrade

    #_log "Updating and installing Ubuntu drivers..."
    #sudo ubuntu-drivers install

    _log "Removing residual configs..."
    dpkg -l | grep '^rc' | awk '{print $2}' | xargs sudo apt-get -y purge

    _log "Removing unused packages..."
    sudo apt-get -y autoremove --purge

    _log "Updating Pi-hole..."
    local BACKUP_FLAGS=$-
    set +u
    pihole -up
    set -"$BACKUP_FLAGS"

    echo "Done!"
}

_log() {
    local MESSAGE=$1

    logger -s "[$SCRIPT_NAME] $MESSAGE"
}

_main "$@"
