#!/usr/bin/env bash

MONITOR_WIDTH=1920
MONITOR_HEIGHT=1080

EYE_WINDOW_WIDTH=640  # i think this is adjustable
EYE_WINDOW_HEIGHT=16384  # this is important for pixel perfect measurement

BT_WINDOW_WIDTH=350
BT_WINDOW_HEIGHT=900

WIDE_WINDOW_WIDTH=1920
WIDE_WINDOW_HEIGHT=330

MC_WINDOW_CLASS_RE="^Minecraft.*$" # this will match e. g. `Minecraft* 1.16.1`

# The state file which contains "1" if keybinds are enabled and "0" if not.
# Managed by another script.
STATE_FILE="/tmp/keyd_profile_state.txt"

# Exit codes
EXIT_SUCCESS=0
EXIT_INVALID_ARGUMENTS=1
EXIT_NOT_A_MINECRAFT_WINDOW=2
EXIT_KEYBINDS_DISABLED=3

window_resize () {
    local width=$1
    local height=$2

    # center the window, move first to avoid weird cursor issues
    local pos_x=$(( ($MONITOR_WIDTH - $width) / 2 ))
    local pos_y=$(( ($MONITOR_HEIGHT - $height) / 2 ))
    hyprctl dispatch movewindowpixel \
        "exact $pos_x $pos_y,initialclass:$MC_WINDOW_CLASS_RE"
    hyprctl dispatch resizewindowpixel \
        exact $width $height,initialclass:$MC_WINDOW_CLASS_RE
    return $EXIT_SUCCESS
}

macro_resize () {
    local width=$1
    local height=$2

    local window_info=$( hyprctl activewindow -j )

    # raw jq output to remove quotes around window class
    local window_class=$( echo "$window_info" | jq -r ".initialClass" )
    if ! [[ $window_class =~ $MC_WINDOW_CLASS_RE ]]; then
        return $EXIT_NOT_A_MINECRAFT_WINDOW
    fi

    local window_size=$( echo "$window_info" | jq ".size" )
    local x=$( echo "$window_size" | jq ".[0]" )
    local y=$( echo "$window_size" | jq ".[1]" )
    # if trying to apply the same macro, reset to borderless
    if [[ $x -eq $width && $y -eq $height ]] && \
       [[ $x -ne $MONITOR_WIDTH || $y -ne $MONITOR_HEIGHT ]]; then
        window_resize $MONITOR_WIDTH $MONITOR_HEIGHT
        return $EXIT_SUCCESS
    fi

    window_resize $width $height
    return $EXIT_SUCCESS
}

if [[ -f $STATE_FILE ]]; then
    state=$( cat $STATE_FILE )
    if [[ "$state" == "0" ]]; then
        exit $EXIT_KEYBINDS_DISABLED
    fi
else
    exit $EXIT_KEYBINDS_DISABLED
fi


case $1 in
    "bt" | "thin")
        macro_resize $BT_WINDOW_WIDTH $BT_WINDOW_HEIGHT ;;
    "eye" | "boat")
        macro_resize $EYE_WINDOW_WIDTH $EYE_WINDOW_HEIGHT ;;
    "wide" | "planar")
        macro_resize $WIDE_WINDOW_WIDTH $WIDE_WINDOW_HEIGHT ;;
    "borderless" | "reset")
        macro_resize $MONITOR_WIDTH $MONITOR_HEIGHT ;;
    *)
        echo "Unknown macro name, available macros are bt/thin, eye/boat, wide/planar, borderless/reset"
        exit $EXIT_INVALID_ARGUMENTS ;;
esac
exit $?
