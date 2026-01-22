#!/usr/bin/env bash

STATE_FILE="/tmp/layout_profile_state.txt"
STATE_MC="mc"
STATE_DEFAULT="default"

if [ -f "$STATE_FILE" ]; then
    CURRENT_STATE=$(cat "$STATE_FILE")
    if [ "$CURRENT_STATE" == "$STATE_MC" ]; then
        hyprctl keyword input:kb_layout us,ru
        echo $STATE_DEFAULT > "$STATE_FILE"
    else
        hyprctl keyword input:kb_layout mc
        echo $STATE_MC > "$STATE_FILE"
    fi
else
    hyprctl keyword input:kb_layout mc
    touch "$STATE_FILE"
    chmod +w "$STATE_FILE"
    echo $STATE_MC > "$STATE_FILE"
fi
