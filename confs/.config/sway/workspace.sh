#! /bin/bash

workspaces=$(swaymsg -t get_workspaces | jq -r '.[].name')

if [ "$1" == "go_to_workspace" ]
then
  workspace=$(echo "$workspaces" | fuzzel --dmenu --no-fuzzy --prompt 'Go to: ')
  swaymsg "workspace $workspace"
elif [ "$1" == "move_to_workspace" ]
then
  workspace=$(echo "$workspaces" | fuzzel --dmenu --no-fuzzy --prompt 'Move to: ')
  swaymsg "move container to workspace $workspace"
  swaymsg "workspace $workspace"
fi
