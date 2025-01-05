#! /bin/bash

workspaces=$(swaymsg -t get_workspaces | jq -r '.[].name')

case "$1" in
  go_to_workspace)
    workspace=$(echo "$workspaces" | fuzzel --dmenu --match-mode exact --placeholder 'Go to workspace')
    swaymsg "workspace $workspace"
  ;;
  move_to_workspace)
    workspace=$(echo "$workspaces" | fuzzel --dmenu --match-mode exact --placeholder 'Move to workspace')
    swaymsg "move container to workspace $workspace"
    swaymsg "workspace $workspace"
  ;;
esac
