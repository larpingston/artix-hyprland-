#!/bin/bash
exec > /tmp/autoclicker.log 2>&1
set -x

PIDFILE="/tmp/autoclicker.pid"

if [ -f "$PIDFILE" ]; then
    /usr/bin/pkill -P "$(cat $PIDFILE)" 2>/dev/null
    rm "$PIDFILE"
    /usr/bin/pkill ydotoold
    exit 0
fi

pgrep ydotoold > /dev/null || /usr/bin/ydotoold &
(
    while true; do
        /usr/bin/ydotool click 0xC0
        sleep 5
    done
) &

echo $! > "$PIDFILE"
