#!/bin/bash

set -e

if [[ $# = 0 && -t 0 && -t 1 ]]; then
    exec bash
else
    if [ "$1" = 'supervisord' ]; then
        chown -R "$CRAFTER_USER" "$CRAFTER_ROOT/data"
        mkdir -p "$CRAFTER_ROOT"/.ssh
        chmod 700 "$CRAFTER_ROOT"/.ssh
        echo "$SSH_KNOWN_HOSTS" > "$CRAFTER_ROOT"/.ssh/known_hosts
        echo "$SSH_PRIVATE_KEY"| tr -d '\r'  > "$CRAFTER_ROOT"/.ssh/id_rsa
        chmod 600 "$CRAFTER_ROOT"/.ssh/known_hosts "$CRAFTER_ROOT"/.ssh/id_rsa

        exec /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
    else
        exec "$@"
    fi
fi
