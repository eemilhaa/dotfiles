#!/bin/bash

dimensions=$(slurp)
width_x_height="${dimensions#* }"
width="${width_x_height%x*}"
height="${width_x_height#*x}"

swaymsg for_window [app_id="imv" title="magnify"] floating enable
swaymsg for_window [app_id="imv" title="magnify"] border normal 1
swaymsg for_window [app_id="imv" title="magnify"] resize set width "$width" height "$height"
swaymsg for_window [app_id="imv" title="magnify"] move position cursor

TMP=$(mktemp)
grim -g "$dimensions" - > "$TMP" && imv -w magnify "$TMP"
rm "$TMP"
