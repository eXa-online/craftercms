#!/bin/bash

set -e

if [[ $# = 0 && -t 0 && -t 1 ]]; then
    exec bash
else
    chown -R "$CRAFTER_USER:$CRAFTER_USER" "$CRAFTER_ROOT/data"
    chown -R "$CRAFTER_USER:$CRAFTER_USER" "$CRAFTER_ROOT/logs"
    chown -R "$CRAFTER_USER:$CRAFTER_USER" "$CRAFTER_ROOT/.ssh"

    if [ "$1" = 'supervisord' ]; then
        exec /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
    else
        exec "$@"
    fi
fi
