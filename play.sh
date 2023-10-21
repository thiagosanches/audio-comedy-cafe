#!/bin/bash

AUDIO="$1"
PID=$(pgrep "mplayer")

if [ -z "$PID" ]
then
    mplayer "$AUDIO" 2>/dev/null 1>/dev/null
else
    kill -9 "$PID" 2>/dev/null 1>/dev/null
fi
