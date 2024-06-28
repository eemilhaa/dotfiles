#! /bin/bash

if [ "$1" == "go_to" ]
then
  mark=$(fuzzel --dmenu --lines 0 --inner-pad 0 --prompt 'Go to mark: ')

  if [ ${#mark} -ge 1 ]
  then
    swaymsg "[con_mark=$mark] focus"
    echo $1
  fi
elif [ "$1" == "add" ]
then
  swaymsg "mark $(fuzzel --dmenu --lines 0 --inner-pad 0 --prompt 'Add mark: ')"
fi
