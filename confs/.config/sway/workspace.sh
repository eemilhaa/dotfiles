#! /bin/bash

workspaces=$(swaymsg -t get_workspaces | jq -r '.[].name')

case "$1" in
  go_to_workspace)
    workspace=$(echo "$workspaces" | fuzzel --dmenu --no-fuzzy --prompt 'Go to: ')
    swaymsg "workspace $workspace"
  ;;
  move_to_workspace)
    workspace=$(echo "$workspaces" | fuzzel --dmenu --no-fuzzy --prompt 'Move to: ')
    swaymsg "move container to workspace $workspace"
    swaymsg "workspace $workspace"
  ;;
esac
