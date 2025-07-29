#!/bin/bash

pid=$(pgrep -x waybar)

if [ -z "$pid" ]; then
  waybar &
else
  kill "$pid"
fi

