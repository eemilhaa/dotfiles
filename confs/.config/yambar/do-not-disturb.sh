#!/bin/bash

case "$1" in
  toggle)
    makoctl mode -t do-not-disturb
  ;;
esac

modes=$(makoctl mode)

if [[ "${modes}" == *"do-not-disturb"* ]]; then
  state="on"
else
  state="off"
fi

echo "state|string|${state}"
echo ""
