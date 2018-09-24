#!/bin/bash

set -e

if [[ $# = 0 && -t 0 && -t 1 ]]; then
    exec bash
else
    if [ "$1" = 'supervisord' ]; then
        chown -R "$CRAFTER_USER" "$CRAFTER_ROOT/data"

        exec /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
    else
        exec "$@"
    fi
fi
