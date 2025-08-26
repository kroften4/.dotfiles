#!/usr/bin/env bash

DEFAULT_PROFILE_COMMAND="$HOME/scripts/keyd_programming.sh"
MC_PROFILE_COMMAND="$HOME/scripts/keyd_minecraft.sh"

STATE_FILE="/tmp/keyd_profile_state.txt"

if [ -f "$STATE_FILE" ]; then
    CURRENT_STATE=$(cat "$STATE_FILE")
    if [ "$CURRENT_STATE" == "1" ]; then
        eval "$DEFAULT_PROFILE_COMMAND"
        echo "0" > "$STATE_FILE"
    else
        eval "$MC_PROFILE_COMMAND"
        echo "1" > "$STATE_FILE"
    fi
else
    eval "$MC_PROFILE_COMMAND"
    touch "$STATE_FILE"
    echo "1" > "$STATE_FILE"
fi
