#!/bin/bash
[ $(cat /sys/class/power_supply/BAT0/capacity) -lt 25 ] && [ "$(cat /sys/class/power_supply/BAT0/status)" = "Discharging" ] && DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send -u critical "BATTERY LOW"
